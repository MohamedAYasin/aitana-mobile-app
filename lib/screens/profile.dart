import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController(text: "Mohamed Yasino");
  final _emailController = TextEditingController(text: "mayasinalu@gmail.com");
  final _usernameController = TextEditingController(text: "mayasino");
  final _phoneController = TextEditingController(text: "+250799358985");

  bool _editing = false;

  void _toggleEditing() {
    setState(() {
      _editing = !_editing;
    });
  }

  void _saveProfile() {
    // Here you would add logic to save the profile data (e.g., Firebase, SharedPreferences, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Profile updated successfully')),
    );
    setState(() => _editing = false);
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    const inputFill = Color(0xFFF0F4F7);

    return Scaffold(
      appBar: AppBar(
        title: const Text("👤 My Profile"),
        actions: [
          IconButton(
            icon: Icon(_editing ? Icons.check : Icons.edit),
            onPressed: _editing ? _saveProfile : _toggleEditing,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/yasino.jpg'),
            ),
            const SizedBox(height: 20),
            _buildProfileField("Full Name", _nameController, _editing),
            const SizedBox(height: 15),
            _buildProfileField("Email", _emailController, false), // Email usually non-editable
            const SizedBox(height: 15),
            _buildProfileField("Username", _usernameController, _editing),
            const SizedBox(height: 15),
            _buildProfileField("Phone", _phoneController, _editing),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller, bool editable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: editable,
          decoration: InputDecoration(
            filled: true,
            fillColor: editable ? const Color(0xFFE8F4EC) : const Color(0xFFF4F4F4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
