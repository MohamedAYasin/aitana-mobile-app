import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ClassifyScreen extends StatefulWidget {
  const ClassifyScreen({Key? key}) : super(key: key);

  @override
  State<ClassifyScreen> createState() => _ClassifyScreenState();
}

class _ClassifyScreenState extends State<ClassifyScreen> {
  File? _image;
  Uint8List? _webImageBytes;
  final picker = ImagePicker();
  bool _loading = false;
  String? _label;
  String? _confidence;
  String? _funFact;
  List<Map<String, String>> _reuseIdeas = [];

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImageBytes = bytes;
          _image = null;
        });
      } else {
        setState(() {
          _image = File(pickedFile.path);
          _webImageBytes = null;
        });
      }
    }
  }

  Future<void> _classifyImage() async {
    if (_image == null && _webImageBytes == null) return;

    setState(() {
      _loading = true;
      _label = null;
      _confidence = null;
      _funFact = null;
      _reuseIdeas.clear();
    });

    final uri = Uri.parse('https://yasino007-aitana-app-api.hf.space//predict');
    final request = http.MultipartRequest('POST', uri);

    if (kIsWeb) {
      request.files.add(
        http.MultipartFile.fromBytes('image', _webImageBytes!, filename: 'upload.jpg'),
      );
    } else {
      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _label = data['label'];
          _confidence = data['confidence'];
          _funFact = (data['funFacts'] as List).isNotEmpty ? data['funFacts'][0] : '';
          _reuseIdeas = (data['reuseIdeas'] as List)
              .cast<Map<String, dynamic>>()
              .map((idea) => {
                    'title': idea['title'].toString(),
                    'url': idea['url'].toString(),
                  })
              .toList()
            ..shuffle();
        });

        final prefs = await SharedPreferences.getInstance();
        List<String> history = prefs.getStringList('history') ?? [];
        final historyEntry = {
          'label': data['label'],
          'date': DateTime.now().toIso8601String(),
        };
        history.add(jsonEncode(historyEntry));
        await prefs.setStringList('history', history);
      } else {
        throw Exception('Failed to classify');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  Widget _mainCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.blue,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.6), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (_webImageBytes != null) {
      return Image.memory(_webImageBytes!, height: 200);
    } else if (_image != null) {
      return Image.file(_image!, height: 200);
    } else {
      return const SizedBox(height: 200);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classify E-Waste'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _mainCard(
                    title: '📷 Choose Image',
                    icon: Icons.image_search_outlined,
                    onTap: _pickImage,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  _mainCard(
                    title: _loading ? '⏳ Classifying...' : '♻️ Classify & Suggest',
                    icon: Icons.recycling,
                    onTap: _loading ? () {} : _classifyImage,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 30),
                  _buildImagePreview(),
                  const SizedBox(height: 10),
                  if (_label != null)
                    Card(
                      color: isDark ? Colors.grey[800] : Colors.grey[100],
                      margin: const EdgeInsets.all(16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("✅ Item: $_label", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 8),
                            Text("📊 Confidence: $_confidence"),
                            const SizedBox(height: 8),
                            if (_funFact != null)
                              Text("📘 Fun Fact: $_funFact"),
                            const SizedBox(height: 12),
                            if (_reuseIdeas.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("💡 Reuse Ideas:", style: TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 6),
                                  ..._reuseIdeas.take(2).map(
                                    (idea) => GestureDetector(
                                      onTap: () => launchURL(idea['url']!),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.link, size: 16, color: Colors.blue),
                                            const SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                idea['title']!,
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
