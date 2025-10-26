import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryRepository {
  static const _key = 'search_history';
  static const _maxHistory = 10; // limitar as últimas 10 buscas

  Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> addSearchTerm(String term) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_key) ?? [];

    term = term.trim();
    if (term.isEmpty) return;

    // Remove repetições e coloca no topo
    history.remove(term);
    history.insert(0, term);

    // Mantém só os últimos _maxHistory itens
    if (history.length > _maxHistory) {
      history.removeRange(_maxHistory, history.length);
    }

    await prefs.setStringList(_key, history);
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}