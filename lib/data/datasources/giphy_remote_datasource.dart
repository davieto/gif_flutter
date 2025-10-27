import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../domain/entities/gif_entity.dart';

class GiphyRemoteDataSource {
  Future<List<GifEntity>> fetchTrending({int limit = 25}) async {
    final uri = Uri.https('api.giphy.com', '/v1/gifs/trending', {
      'api_key': ApiConstants.apiKey,
      'limit': limit.toString(),
      'rating': 'g',
    });

    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body)['data'] as List<dynamic>;
      return data.map((e) {
        final images = e['images'];
        return GifEntity(
          id: e['id'],
          title: e['title'] ?? '',
          url: images['downsized_medium']?['url'] ??
              images['original']?['url'] ??
              '',
        );
      }).toList();
    } else {
      throw Exception('Erro ${res.statusCode}');
    }
  }

  Future<List<GifEntity>> searchGifs(String query, {int limit = 25}) async {
    final uri = Uri.https('api.giphy.com', '/v1/gifs/search', {
      'api_key': ApiConstants.apiKey,
      'q': query,
      'limit': limit.toString(),
      'rating': 'g',
    });

    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body)['data'] as List<dynamic>;
      return data.map((e) {
        final images = e['images'];
        return GifEntity(
          id: e['id'],
          title: e['title'] ?? '',
          url: images['downsized_medium']?['url'] ??
              images['original']?['url'] ??
              '',
        );
      }).toList();
    } else {
      throw Exception('Erro ${res.statusCode}');
    }
  }
}