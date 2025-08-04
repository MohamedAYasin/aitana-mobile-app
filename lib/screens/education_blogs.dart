import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationBlogsScreen extends StatelessWidget {
  const EducationBlogsScreen({super.key});

  final List<Map<String, String>> blogs = const [
    {"title": "Electronic Waste E-Waste", "url": "https://www.who.int/news-room/fact-sheets/detail/electronic-waste-(e-waste)/"},
    {"title": "Sustainable Future of E-waste", "url": "https://www.unep.org/ietc/news/story/sustainable-future-e-waste"},
    {"title": "The Global Impact of E-Waste", "url": "https://www.ilo.org/publications/global-impact-e-waste-addressing-challenge"},
    {"title": "The Growing Environmental Risks of E-Waste", "url": "https://www.genevaenvironmentnetwork.org/resources/updates/the-growing-environmental-risks-of-e-waste/"},
    {"title": "Impact of e-waste on human health", "url": "https://www.who.int/news/item/15-06-2021-soaring-e-waste-affects-the-health-of-millions-of-children-who-warns"},
    {"title": "Circular economy in Africa: Electronics and e-waste", "url": "https://content.ellenmacarthurfoundation.org/m/7a9fb09b78cdf3f5/original/Circular-economy-in-Africa-Electronics-and-e-waste.pdf?_gl=1*mbcjxv*_ga*ODU5MDc3MDkwLjE3NTM5MTIxMzc.*_ga_V32N675KJX*czE3NTM5MTIxMzQkbzEkZzAkdDE3NTM5MTIxMzckajYwJGwwJGgw*_gcl_au*MTk1NjMwOTE2OS4xNzUzOTEyMTM4"},
    {"title": "How circular economy models can address global e-waste", "url": "https://www.ey.com/en_us/insights/climate-change-sustainability-services/how-circular-economy-models-can-address-global-e-waste"},
    {"title": "Ways to Reduce e-Waste", "url": "https://www.wcrecycler.com/blog/top-10-ways-to-reduce-e-waste"},
    {"title": "How to Sustainably Dispose of Your Technological Waste", "url": "https://sustainability.yale.edu/blog/how-sustainably-dispose-your-technological-waste"},
    {"title": "The Responsible Guide to Disposing of E-Waste: A Greener Future Starts at Home", "url": "https://landbellcanada.com/disposing-of-e-waste/"},
    {"title": "Sustainable e-waste management: A growing challenge for Africa", "url": "https://vellum.co.ke/sustainable-e-waste-management-a-growing-challenge-for-africa/"},
    {"title": "The Future of E-waste Management: Circular Economy Principles for Sustainable Electronics", "url": "https://ecircular.com/waste-management-circular-economy-principles/"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📰 Documents")),
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
