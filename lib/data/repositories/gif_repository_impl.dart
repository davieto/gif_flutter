import '../../domain/entities/gif_entity.dart';
import '../../domain/repositories/gif_repository.dart';
import '../datasources/giphy_remote_datasource.dart';
import '../datasources/local_storage_datasource.dart';

/// Implementa os métodos definidos no domínio, unificando API e armazenamento local.
class GifRepositoryImpl implements GifRepository {
  final GiphyRemoteDataSource remote;
  final LocalStorageDataSource local;

  GifRepositoryImpl(this.remote, this.local);

  @override
  Future<GifEntity> getRandomGif({String tag = '', String rating = 'g'}) async {
    return await remote.fetchRandom(tag: tag, rating: rating);
  }

  @override
  Future<void> toggleFavorite(String id) => local.toggleFavorite(id);

  @override
  Future<List<String>> getFavorites() => local.getFavorites();
}