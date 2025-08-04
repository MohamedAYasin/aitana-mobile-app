import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? _profileImageBase64;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  void _toggleEditing() {
    setState(() => _editing = !_editing);
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Profile updated successfully')),
    );
    setState(() => _editing = false);
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImageBase64 = prefs.getString('profile_image');
    });
  }

  Future<void> _pickNewProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', base64Image);

      setState(() {
        _profileImageBase64 = base64Image;
      });
    }
  }

  void _showProfileOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.visibility),
                title: const Text('View Profile Picture'),
                onTap: () {
                  Navigator.pop(context);
                  _showProfilePicturePreview();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Change Profile Picture'),
                onTap: () {
                  Navigator.pop(context);
                  _pickNewProfileImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showProfilePicturePreview() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: InteractiveViewer(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _profileImageBase64 != null
                ? Image.memory(base64Decode(_profileImageBase64!))
                : Image.asset('assets/images/profilepic.avif'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inputColor = isDark ? Colors.grey[800] : Colors.grey[200];
    final textColor = isDark ? Colors.white : Colors.black87;

    final avatar = _profileImageBase64 != null
        ? MemoryImage(base64Decode(_profileImageBase64!))
        : const AssetImage('assets/images/profilepic.avif') as ImageProvider;

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
            GestureDetector(
              onTap: _showProfileOptions,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: avatar,
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileField("Full Name", _nameController, _editing, inputColor, textColor),
            const SizedBox(height: 15),
            _buildProfileField("Email", _emailController, false, inputColor, textColor),
            const SizedBox(height: 15),
            _buildProfileField("Username", _usernameController, _editing, inputColor, textColor),
            const SizedBox(height: 15),
            _buildProfileField("Phone", _phoneController, _editing, inputColor, textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(
    String label,
    TextEditingController controller,
    bool editable,
    Color? fillColor,
    Color textColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: editable,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
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
