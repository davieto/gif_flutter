import 'package:flutter/material.dart';
import '../../core/utils/debouncer.dart';
import '../../data/repositories/search_history_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  final _historyRepo = SearchHistoryRepository();

  List<String> _history = [];
  bool _showHistory = false;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await _historyRepo.getHistory();
    setState(() {
      _history = history;
    });
  }

  void _onSearchChanged(String value) {
    _debouncer.run(() {
      setState(() => _showHistory = false);
      _historyRepo.addSearchTerm(value);
      _loadHistory(); // atualiza o histórico
    });
  }

  void _onFocus() {
    setState(() => _showHistory = true);
  }

  void _onSelectHistory(String term) {
    _controller.text = term;
    setState(() => _showHistory = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Busca com histórico')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de busca
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Buscar GIFs',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged,
              onTap: _onFocus,
            ),

            const SizedBox(height: 8),

            // Mostra histórico de buscas
            if (_showHistory && _history.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final term = _history[index];
                    return ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(term),
                      onTap: () => _onSelectHistory(term),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () async {
                          _history.removeAt(index);
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setStringList(SearchHistoryRepository._key, _history);
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ),

            if (_showHistory && _history.isEmpty)
              const Expanded(
                child: Center(child: Text('Sem histórico de busca.')),
              ),
          ],
        ),
      ),
    );
  }
}