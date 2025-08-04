import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationVideosScreen extends StatelessWidget {
  const EducationVideosScreen({super.key});

  final List<Map<String, String>> videos = const [
    {"title": "What is E-Waste?", "url": "https://www.youtube.com/watch?v=HQZjouMTH08&ab_channel=OregonPublicBroadcasting"},
    {"title": "What is E-WASTE Pollution? ", "url": "https://www.youtube.com/watch?v=MQLadfsvfLo"},
    {"title": "How to turn e-waste into a circular economy", "url": "https://www.youtube.com/watch?v=PDf95jyZ7PU"},
    {"title": "How to Get Rid of All Your E-Waste", "url": "https://www.youtube.com/watch?v=IIM9-kBRh1A"},
    {"title": "How is e-waste harming our world", "url": "https://www.youtube.com/watch?v=-uyIzKIw0xY"},
    {"title": "What is the circular economy?", "url": "https://www.youtube.com/watch?v=__0Spwj8DkM"},
    {"title": "E-Waste Explained By A Sustainability Expert", "url": "https://www.youtube.com/watch?v=_Y2ePj3wr8M"},
    {"title": "E-Waste Crisis in Africa: A Growing Threat", "url": "https://www.youtube.com/watch?v=0HBHKC2tkZ8"},
    {"title": "The Problem With E-Waste", "url": "https://www.youtube.com/watch?v=FmJFVmtWf-I"},
    {"title": "Reduce, Reuse, Recycle", "url": "https://www.youtube.com/watch?v=uCDOm4AcPQk"},
    {"title": "The tragic costs of e-waste", "url": "https://www.youtube.com/watch?v=4GtWGHvX-rk"},
    {"title": "e-Waste | How Your Old Gadgets Impact the Environment", "url": "https://www.youtube.com/watch?v=HV2Ir1e513o"},
    {"title": "Electronic Waste Crisis Solution", "url": "https://www.youtube.com/watch?v=e90eD-qXvFs"}
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
