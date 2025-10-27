import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/giphy_remote_datasource.dart';
import '../../domain/entities/gif_entity.dart';

class GifState {
  final bool loading;
  final List<GifEntity> gifs;
  final String? error;

  const GifState({
    this.loading = false,
    this.gifs = const [],
    this.error,
  });

  GifState copyWith({
    bool? loading,
    List<GifEntity>? gifs,
    String? error,
  }) {
    return GifState(
      loading: loading ?? this.loading,
      gifs: gifs ?? this.gifs,
      error: error,
    );
  }
}

class GifNotifier extends StateNotifier<GifState> {
  final GiphyRemoteDataSource giphyApi;

  GifNotifier(this.giphyApi) : super(const GifState());

  Future<void> fetchTrending() async {
    state = state.copyWith(loading: true, error: null);

    try {
      final result = await giphyApi.fetchTrending(limit: 25);
      if (result.isEmpty) {
        state = state.copyWith(loading: false, gifs: []);
      } else {
        state = state.copyWith(loading: false, gifs: result);
      }
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: 'Falha ao carregar GIFs: ${e.toString()}',
      );
    }
  }

  Future<void> searchGifs(String query) async {
    if (query.trim().isEmpty) {
      await fetchTrending();
      return;
    }

    state = state.copyWith(loading: true, error: null);

    try {
      final result = await giphyApi.searchGifs(query, limit: 25);
      if (result.isEmpty) {
        state = state.copyWith(loading: false, gifs: []);
      } else {
        state = state.copyWith(loading: false, gifs: result);
      }
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: 'Erro na busca: ${e.toString()}',
      );
    }
  }
}

final gifProvider = StateNotifierProvider<GifNotifier, GifState>((ref) {
  return GifNotifier(GiphyRemoteDataSource());
});