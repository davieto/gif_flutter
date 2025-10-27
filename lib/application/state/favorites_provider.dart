import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local_storage_datasource.dart';

class FavoritesNotifier extends StateNotifier<List<String>> {
  final LocalStorageDataSource storage;

  FavoritesNotifier(this.storage) : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    state = await storage.getFavoriteIds();
  }

  Future<void> toggleFavorite(String id) async {
    await storage.toggleFavorite(id);
    state = await storage.getFavoriteIds();
  }

  bool isFavorite(String id) => state.contains(id);
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  return FavoritesNotifier(LocalStorageDataSource());
});