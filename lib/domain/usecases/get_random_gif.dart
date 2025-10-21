import '../entities/gif_entity.dart';
import '../repositories/gif_repository.dart';

class GetRandomGif {
  final GifRepository repository;

  GetRandomGif(this.repository);

  Future<GifEntity> call({String tag = '', String rating = 'g'}) {
    return repository.getRandomGif(tag: tag, rating: rating);
  }
}