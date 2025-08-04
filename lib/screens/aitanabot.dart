import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AitanaBotScreen extends StatefulWidget {
  const AitanaBotScreen({Key? key}) : super(key: key);

  @override
  State<AitanaBotScreen> createState() => _AitanaBotScreenState();
}

class _AitanaBotScreenState extends State<AitanaBotScreen> {
  final List<_ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  bool _isSending = false;

  static const String _apiUrl = "https://aitanabot.onrender.com//chat";
  String? _profileImageBase64;

  @override
  void initState() {
    super.initState();
    _messages.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _messages.add(_ChatMessage(
          text:
              "Hi there! I'm AITANABOT 🤖. Ask me anything about e-waste, sustainability, or climate change!",
          isUser: false,
        ));
      });
    });
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImageBase64 = prefs.getString('profile_image');
    });
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _isSending = true;
    });
    _controller.clear();
    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "messages": [
            {"role": "user", "content": text}
          ]
        }),
      );

      final data = json.decode(response.body);
      setState(() {
        _messages.add(_ChatMessage(
          text: data['response'] ?? "You exceeded your current quota. Please come back 24 hours later.",
          isUser: false,
        ));
      });
    } catch (e) {
      setState(() {
        _messages.add(_ChatMessage(
          text: "⚠️ Error: $e",
          isUser: false,
        ));
      });
    } finally {
      setState(() => _isSending = false);
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollCtrl.hasClients) {
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const botAvatar = 'assets/images/aitanabott.png';
    const userAvatar = 'assets/images/yasino.jpg';
    final userBubble = isDark ? Colors.blueGrey.shade800 : const Color(0xFFD6E6FF);
    final botBubble = isDark ? Colors.grey.shade800 : const Color(0xFFF1F5F9);
    final inputFill = isDark ? Colors.blueGrey.shade900 : const Color(0xFFE3F2FD);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("🤖 AITANABOT"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcome_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    final avatar = msg.isUser
                        ? (_profileImageBase64 != null
                            ? MemoryImage(base64Decode(_profileImageBase64!))
                            : const AssetImage(userAvatar))
                        : const AssetImage(botAvatar);

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: msg.isUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        if (!msg.isUser)
                          CircleAvatar(
                              radius: 16, backgroundImage: avatar as ImageProvider),
                        if (!msg.isUser) const SizedBox(width: 8),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: msg.isUser ? userBubble : botBubble,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              msg.text,
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.4,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        if (msg.isUser) const SizedBox(width: 8),
                        if (msg.isUser)
                          CircleAvatar(
                              radius: 16, backgroundImage: avatar as ImageProvider),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: MediaQuery.of(context).padding.bottom + 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: "Ask about e-waste, sustainability...",
                          filled: true,
                          fillColor: inputFill,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _isSending
                        ? const CircularProgressIndicator()
                        : IconButton(
                            icon: const Icon(Icons.send),
                            color: Colors.blue,
                            onPressed: _sendMessage,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  _ChatMessage({required this.text, required this.isUser});
}
