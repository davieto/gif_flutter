import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => history = prefs.getStringList('search_history') ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de buscas')),
      body: history.isEmpty
          ? const Center(child: Text('Nenhum termo buscado ainda.'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, i) => ListTile(
                leading: const Icon(Icons.history),
                title: Text(history[i]),
              ),
            ),
    );
  }
}