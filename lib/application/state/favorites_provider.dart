import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/database/app_database.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Map<String, dynamic>>>(
        (ref) => FavoritesNotifier());

class FavoritesNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  FavoritesNotifier() : super([]) {
    load();
  }

  Future<void> load() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query('favorites');
    state = result;
  }

  Future<void> toggleFavorite(Map<String, dynamic> gif) async {
    final db = await AppDatabase.instance.database;
    final exists = state.any((e) => e['id'] == gif['id']);

    if (exists) {
      await db.delete('favorites', where: 'id = ?', whereArgs: [gif['id']]);
    } else {
      await db.insert('favorites', {
        'id': gif['id'],
        'title': gif['title'],
        'url': gif['url'],
      });
    }
    await load();
  }

  bool isFavorite(String id) => state.any((e) => e['id'] == id);
}