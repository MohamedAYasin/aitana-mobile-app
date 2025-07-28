import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistorySection extends StatefulWidget {
  const HistorySection({Key? key}) : super(key: key);

  @override
  State<HistorySection> createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedHistory =
        prefs.getStringList('classified_history') ?? [];
    setState(() {
      _history = savedHistory.reversed.take(10).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _history.isEmpty
        ? const Padding(
            padding: EdgeInsets.all(16),
            child: Text("No classification history yet."),
          )
        : Column(
            children: _history
                .map((item) => ListTile(
                      leading: const Icon(Icons.device_hub),
                      title: Text(item),
                    ))
                .toList(),
          );
  }
}
