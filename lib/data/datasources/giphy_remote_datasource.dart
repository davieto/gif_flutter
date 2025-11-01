import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../domain/entities/gif_entity.dart';

class GiphyRemoteDataSource {
  Future<Map<String, dynamic>> fetchTrending({
    int limit = 25,
    int offset = 0,
  }) async {
    final uri = Uri.https('api.giphy.com', '/v1/gifs/trending', {
      'api_key': ApiConstants.apiKey,
      'limit': limit.toString(),
      'offset': offset.toString(),
      'rating': 'g',
    });

    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      final data = body['data'] as List<dynamic>;
      final pagination = body['pagination'] as Map<String, dynamic>?;
      final total = pagination != null && pagination['total_count'] != null
          ? (pagination['total_count'] as int)
          : data.length;
      final gifs = data.map((e) {
        final images = e['images'];
        return GifEntity(
          id: e['id'],
          title: e['title'] ?? '',
          url:
              images['downsized_medium']?['url'] ??
              images['original']?['url'] ??
              '',
        );
      }).toList();
      return {'gifs': gifs, 'total': total};
    } else {
      throw Exception('Erro ${res.statusCode}');
    }
  }

  Future<Map<String, dynamic>> searchGifs(
    String query, {
    int limit = 25,
    int offset = 0,
  }) async {
    final uri = Uri.https('api.giphy.com', '/v1/gifs/search', {
      'api_key': ApiConstants.apiKey,
      'q': query,
      'limit': limit.toString(),
      'offset': offset.toString(),
      'rating': 'g',
    });

    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      final data = body['data'] as List<dynamic>;
      final pagination = body['pagination'] as Map<String, dynamic>?;
      final total = pagination != null && pagination['total_count'] != null
          ? (pagination['total_count'] as int)
          : data.length;
      final gifs = data.map((e) {
        final images = e['images'];
        return GifEntity(
          id: e['id'],
          title: e['title'] ?? '',
          url:
              images['downsized_medium']?['url'] ??
              images['original']?['url'] ??
              '',
        );
      }).toList();
      return {'gifs': gifs, 'total': total};
    } else {
      throw Exception('Erro ${res.statusCode}');
    }
  }
}
