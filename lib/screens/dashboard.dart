import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void _handleMenuSelection(String choice) {
    switch (choice) {
      case 'Settings':
        Navigator.pushNamed(context, '/settings');
        break;
      case 'About':
        Navigator.pushNamed(context, '/about');
        break;
      case 'Logout':
        Navigator.pushNamed(context, '/login');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Aitana Home"),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        centerTitle: true,
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          color: isDark ? Colors.blue : Colors.blue,
          onSelected: _handleMenuSelection,
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'Settings', child: Text('⚙️ Settings')),
            PopupMenuItem(value: 'About', child: Text('ℹ️ About')),
            PopupMenuItem(value: 'Logout', child: Text('🚪 Logout')),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcome_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _mainCard(
                  title: 'Classify your e-waste items',
                  icon: Icons.camera_alt,
                  onTap: () => Navigator.pushNamed(context, '/classify'),
                  isDark: isDark,
                ),
                const SizedBox(height: 20),
                _mainCard(
                  title: 'Chat and learn with AitanaBot',
                  icon: Icons.chat_bubble_outline,
                  onTap: () => Navigator.pushNamed(context, '/aitanabot'),
                  isDark: isDark,
                ),
                const SizedBox(height: 20),
                _mainCard(
                  title: 'Learn about e-waste',
                  icon: Icons.info_outline,
                  onTap: () => Navigator.pushNamed(context, '/education'),
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          final routes = [null, '/classify', '/aitanabot', '/education', '/settings'];
          if (index != 0) Navigator.pushNamed(context, routes[index]!);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Classify'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'AitanaBot'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Education'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _mainCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
                  colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [Color(0xFF90CAF9), Color(0xFF42A5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black54 : Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
