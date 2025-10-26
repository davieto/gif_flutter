import '../../domain/entities/gif_entity.dart';

class GifModel extends GifEntity {
  const GifModel({
    required super.id,
    required super.title,
    required super.url,
  });

  factory GifModel.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as Map<String, dynamic>;
    final original = images['original'] as Map<String, dynamic>;
    return GifModel(
      id: json['id'] ?? '',
      title: json['title'] ?? 'GIF sem título',
      url: original['url'] ?? '',
    );
  }
}