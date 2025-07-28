import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationVideosScreen extends StatelessWidget {
  const EducationVideosScreen({super.key});

  final List<Map<String, String>> videos = const [
    {"title": "What is E-Waste?", "url": "https://www.youtube.com/watch?v=HQZjouMTH08&ab_channel=OregonPublicBroadcasting"},
    {"title": "The Journey of E-Waste", "url": "https://www.youtube.com/watch?v=VnI7GNKbmAA"},
    {"title": "How to Recycle Electronics", "url": "https://www.youtube.com/watch?v=sxj1HhM9ZBc"},
    {"title": "Why is E-Waste Dangerous?", "url": "https://www.youtube.com/watch?v=0ncbfB7xGFM"},
    {"title": "Circular Economy Explained", "url": "https://www.youtube.com/watch?v=zCRKvDyyHmI"},
    {"title": "Sustainability and Electronics", "url": "https://www.youtube.com/watch?v=Bc9v3J8vP3Q"},
    {"title": "E-Waste in Africa", "url": "https://www.youtube.com/watch?v=8O1VnOwYUrk"},
    {"title": "The Problem of E-Waste", "url": "https://www.youtube.com/watch?v=J1iTQf4mJ-o"},
    {"title": "How to Reduce E-Waste", "url": "https://www.youtube.com/watch?v=-5h8drkHc8o"},
    {"title": "Recycling Electronics at Home", "url": "https://www.youtube.com/watch?v=lMfPQmzks8o"},
    {"title": "Innovation in E-Waste Management", "url": "https://www.youtube.com/watch?v=f9AVtSTOS3k"},
    {"title": "Global E-Waste Crisis", "url": "https://www.youtube.com/watch?v=tYAKtNx5g7A"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📹 Videos")),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return ListTile(
            title: Text(video['title']!),
            trailing: const Icon(Icons.play_arrow),
            onTap: () async {
              final url = Uri.parse(video['url']!);
              if (!await launchUrl(url)) {
                throw 'Could not launch ${video['url']}';
              }
            },
          );
        },
      ),
    );
  }
}
