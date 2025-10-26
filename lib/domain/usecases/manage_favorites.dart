import '../repositories/gif_repository.dart';

class ManageFavorites {
  final GifRepository repository;

  ManageFavorites(this.repository);

  Future<void> toggle(String id) async => repository.toggleFavorite(id);
  Future<List<String>> getAll() async => repository.getFavorites();
}