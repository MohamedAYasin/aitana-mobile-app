import 'package:flutter/material.dart';
import 'history.dart';
import 'theme.dart';
import 'about.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("⚙️ Settings"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: const [
          ExpansionTile(
            title: Text("🕓 History"),
            children: [HistorySection()],
          ),
          ExpansionTile(
            title: Text("🌗 Theme"),
            children: [ThemeSection()],
          ),
          ExpansionTile(
            title: Text("ℹ️ About"),
            children: [AboutSection()],
          ),
        ],
      ),
    );
  }
}
