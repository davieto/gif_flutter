import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/gif_model.dart';

class GiphyRemoteDataSource {
  Future<GifModel> fetchRandom({String tag = '', String rating = 'g'}) async {
    final uri = Uri.https('api.giphy.com', '/v1/gifs/random', {
      'api_key': ApiConstants.apiKey,
      if (tag.isNotEmpty) 'tag': tag,
      'rating': rating,
    });

    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body) as Map<String, dynamic>;
      return GifModel.fromJson(json['data']);
    } else {
      throw Exception('Erro ao buscar GIF (${res.statusCode})');
    }
  }
}