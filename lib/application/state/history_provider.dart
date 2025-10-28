import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<String>>(
        (ref) => HistoryNotifier());

class HistoryNotifier extends StateNotifier<List<String>> {
  HistoryNotifier() : super([]) {
    _load();
  }

  Future<void> _load() async {
    final box = Hive.box('history');
    state = box.values.cast<String>().toList().reversed.toList();
  }

  Future<void> addSearch(String query) async {
    if (query.trim().isEmpty) return;
    final box = Hive.box('history');
    await box.add(query);
    await _load();
  }
}