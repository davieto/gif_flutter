import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageDataSource {
  static const String _favoritesKey = 'favorites_gifs';

  Future<List<String>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }
  
  Future<List<String>> getFavorites() => getFavoriteIds();

  Future<void> toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    await prefs.setStringList(_favoritesKey, favorites);
  }
}