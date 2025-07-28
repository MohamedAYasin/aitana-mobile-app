import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        "Aitana AI is a sustainability-focused app that helps people manage e-waste "
        "by classifying electronics and recommending creative reuse ideas. Together, "
        "we support a circular economy and reduce environmental harm.",
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
