import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SwitchListTile(
      title: const Text("Dark Theme"),
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        themeProvider.toggleTheme(value);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value
                ? "🌙 Dark theme enabled"
                : "☀️ Light theme enabled"),
          ),
        );
      },
    );
  }
}
