import 'package:flutter/material.dart';
import 'theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/loginto');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("⚙️ Settings"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcome_background.png',
              fit: BoxFit.cover,
            ),
          ),

          //Semi-transparent overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          // Main Settings Contents moved
          ListView(
            children: [
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text("Profile", style: TextStyle(color: Colors.white)),
                onTap: () => _navigateTo(context, '/profile'),
              ),
              ExpansionTile(
                title: const Text("🌗 Theme", style: TextStyle(color: Colors.white)),
                children: const [ThemeSection()],
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text("Logout", style: TextStyle(color: Colors.white)),
                onTap: () => _logout(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
