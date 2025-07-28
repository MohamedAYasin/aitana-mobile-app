import 'package:flutter/material.dart';
import 'education_videos.dart';
import 'education_blogs.dart';
import 'education_quiz.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📚 Education')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(context, '📹 Videos', const EducationVideosScreen()),
              const SizedBox(height: 20),
              _buildButton(context, '📰 Blogs', const EducationBlogsScreen()),
              const SizedBox(height: 20),
              _buildButton(context, '📝 Quiz', const EducationQuizScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Widget page) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      ),
      child: Text(text, style: const TextStyle(fontSize: 20)),
    );
  }
}
