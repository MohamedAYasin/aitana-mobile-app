import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationBlogsScreen extends StatelessWidget {
  const EducationBlogsScreen({super.key});

  final List<Map<String, String>> blogs = const [
    {"title": "Electronic Waste E-Waste", "url": "https://www.who.int/news-room/fact-sheets/detail/electronic-waste-(e-waste)/"},
    {"title": "Sustainable Electronics", "url": "https://www.nrdc.org/stories/electronics-and-sustainability"},
    {"title": "The Global Impact of E-Waste", "url": "https://www.weforum.org/agenda/2020/01/the-global-e-waste-challenge/"},
    {"title": "How to Recycle Electronics", "url": "https://www.epa.gov/recycle/electronics-donation-and-recycling"},
    {"title": "What Happens to Your E-Waste?", "url": "https://time.com/5608587/electronic-waste-recycling/"},
    {"title": "Circular Economy for E-Waste", "url": "https://ellenmacarthurfoundation.org/circular-economy-in-detail"},
    {"title": "E-Waste in Developing Countries", "url": "https://www.sciencedirect.com/science/article/pii/S0959652620348362"},
    {"title": "Tips to Reduce E-Waste", "url": "https://www.greenpeace.org/usa/tips-to-reduce-e-waste/"},
    {"title": "The Hidden Cost of E-Waste", "url": "https://www.bbc.com/future/article/20200305-why-your-old-phone-is-more-polluting-than-you-think"},
    {"title": "How to Upcycle Old Electronics", "url": "https://www.makeuseof.com/tag/upcycle-old-electronics-projects/"},
    {"title": "Innovation in Recycling", "url": "https://www.nationalgeographic.com/environment/article/electronic-waste-is-recycling-worth-it"},
    {"title": "The Future of E-Waste Management", "url": "https://www.unep.org/resources/report/future-e-waste"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📰 Blogs")),
      body: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final blog = blogs[index];
          return ListTile(
            title: Text(blog['title']!),
            trailing: const Icon(Icons.open_in_new),
            onTap: () async {
              final url = Uri.parse(blog['url']!);
              if (!await launchUrl(url)) {
                throw 'Could not launch ${blog['url']}';
              }
            },
          );
        },
      ),
    );
  }
}
