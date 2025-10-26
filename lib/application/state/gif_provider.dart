import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/gif_entity.dart';
import '../../domain/usecases/get_random_gif.dart';

/// Estado imutável do GIF (carregando, sucesso, erro)
class GifState {
  final bool loading;
  final GifEntity? gif;
  final String? error;

  const GifState({this.loading = false, this.gif, this.error});

  GifState copyWith({bool? loading, GifEntity? gif, String? error}) {
    return GifState(
      loading: loading ?? this.loading,
      gif: gif ?? this.gif,
      error: error,
    );
  }
}

/// Controlador de estado (Riverpod)
class GifNotifier extends StateNotifier<GifState> {
  final GetRandomGif getRandomGif;

  GifNotifier(this.getRandomGif) : super(const GifState());

  Future<void> fetchRandom() async {
    state = state.copyWith(loading: true, error: null);
    try {
      final gif = await getRandomGif();
      state = state.copyWith(loading: false, gif: gif);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}