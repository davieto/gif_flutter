import '../entities/gif_entity.dart';

abstract class GifRepository {
  Future<GifEntity> getRandomGif({String tag, String rating});
  Future<void> toggleFavorite(String id);
  Future<List<String>> getFavorites();
}