import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Map<String, dynamic>>>(
        (ref) => FavoritesNotifier());

class FavoritesNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  FavoritesNotifier() : super([]) {
    load();
  }

  Future<void> load() async {
    final box = Hive.box('favorites');
    final items = box.values.cast<Map>().toList();
    state = items.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<void> toggleFavorite(Map<String, dynamic> gif) async {
    final box = Hive.box('favorites');
    final exists = state.any((e) => e['id'] == gif['id']);

    if (exists) {
      final keyToRemove = box.keys
          .firstWhere((k) => (box.get(k) as Map)['id'] == gif['id']);
      await box.delete(keyToRemove);
    } else {
      await box.add(gif);
    }
    await load();
  }

  bool isFavorite(String id) => state.any((e) => e['id'] == id);
}