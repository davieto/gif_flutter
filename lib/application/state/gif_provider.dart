import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/gif_entity.dart';
import '../../domain/usecases/get_random_gif.dart';

class GifState {
  final bool loading;
  final GifEntity? gif;
  final String? error;

  GifState({this.loading = false, this.gif, this.error});

  GifState copyWith({bool? loading, GifEntity? gif, String? error}) {
    return GifState(
      loading: loading ?? this.loading,
      gif: gif ?? this.gif,
      error: error,
    );
  }
}

class GifNotifier extends StateNotifier<GifState> {
  final GetRandomGif getRandomGif;

  GifNotifier(this.getRandomGif) : super(GifState());

  Future<void> fetchRandom({String tag = '', String rating = 'g'}) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final gif = await getRandomGif(tag: tag, rating: rating);
      state = state.copyWith(loading: false, gif: gif);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}

// Provedor global
final gifProvider = StateNotifierProvider<GifNotifier, GifState>((ref) {
  // Aqui poderíamos injetar repositórios reais
  throw UnimplementedError('Repositório ainda não injetado');
});