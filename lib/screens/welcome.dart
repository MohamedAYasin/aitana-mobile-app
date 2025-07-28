import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔷 Full-screen background
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcome_background.png', 
              fit: BoxFit.cover,
            ),
          ),

          // 🔷 Centered logo & tagline
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App logo
                Image.asset(
                  'assets/images/aitana.png', // 
                  width: 500,
                  height: 500,
                ),

                const SizedBox(height: 16),

                const Text(
                  'AI-Powered E-Waste Upcycling Assistant',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF004060),
                  ),
                ),
              ],
            ),
          ),

          // 🔷 Bottom Get Started button
          Positioned(
            left: 32,
            right: 32,
            bottom: 48 + MediaQuery.of(context).padding.bottom,
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login'); 
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color(0xFF7CF4A4),
                  elevation: 4,
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A244E),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
