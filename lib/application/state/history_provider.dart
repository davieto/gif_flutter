import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<String>>(
        (ref) => HistoryNotifier());

class HistoryNotifier extends StateNotifier<List<String>> {
  HistoryNotifier() : super([]) {
    _load();
  }

  Future<void> _load() async {
    final db = await AppDatabase.instance.database;
    final res = await db.query('history', orderBy: 'id DESC', limit: 20);
    state = res.map((e) => e['query'] as String).toList();
  }

  Future<void> addSearch(String query) async {
    if (query.trim().isEmpty) return;
    final db = await AppDatabase.instance.database;
    await db.insert('history', {'query': query});
    await _load();
  }
}