import '../repositories/gif_repository.dart';

/// Caso de uso: gerencia lista de favoritos (salvar/remover/listar).
class ManageFavorites {
  final GifRepository repository;

  ManageFavorites(this.repository);

  Future<void> toggle(String id) async => repository.toggleFavorite(id);
  Future<List<String>> getAll() async => repository.getFavorites();
}