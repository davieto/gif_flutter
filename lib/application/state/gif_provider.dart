import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/giphy_remote_datasource.dart';
import '../../domain/entities/gif_entity.dart';

class GifState {
  final bool loading;
  final List<GifEntity> gifs;
  final String? error;
  final int currentPage;
  final int totalPages;
  final int itemsPerPage;
  final String currentQuery;

  const GifState({
    this.loading = false,
    this.gifs = const [],
    this.error,
    this.currentPage = 1,
    this.totalPages = 1,
    this.itemsPerPage = 25,
    this.currentQuery = '',
  });

  GifState copyWith({
    bool? loading,
    List<GifEntity>? gifs,
    String? error,
    int? currentPage,
    int? totalPages,
    int? itemsPerPage,
    String? currentQuery,
  }) {
    return GifState(
      loading: loading ?? this.loading,
      gifs: gifs ?? this.gifs,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      currentQuery: currentQuery ?? this.currentQuery,
    );
  }
}

class GifNotifier extends StateNotifier<GifState> {
  final GiphyRemoteDataSource giphyApi;

  GifNotifier(this.giphyApi) : super(const GifState());

  Future<void> fetchTrending({int page = 1}) async {
    state = state.copyWith(
      loading: true,
      error: null,
      currentPage: page,
      currentQuery: '',
    );
    try {
      final offset = (page - 1) * state.itemsPerPage;
      final res = await giphyApi.fetchTrending(
        limit: state.itemsPerPage,
        offset: offset,
      );
      final gifs = (res['gifs'] as List).cast<GifEntity>();
      final total = res['total'] as int;
      final totalPages = (total / state.itemsPerPage).ceil();
      state = state.copyWith(
        loading: false,
        gifs: gifs,
        totalPages: totalPages,
        currentPage: page,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: 'Falha ao carregar GIFs: ${e.toString()}',
      );
    }
  }

  Future<void> searchGifs(String query, {int page = 1}) async {
    if (query.trim().isEmpty) {
      await fetchTrending(page: page);
      return;
    }
    state = state.copyWith(
      loading: true,
      error: null,
      currentQuery: query,
      currentPage: page,
    );
    try {
      final offset = (page - 1) * state.itemsPerPage;
      final res = await giphyApi.searchGifs(
        query,
        limit: state.itemsPerPage,
        offset: offset,
      );
      final gifs = (res['gifs'] as List).cast<GifEntity>();
      final total = res['total'] as int;
      final totalPages = (total / state.itemsPerPage).ceil();
      state = state.copyWith(
        loading: false,
        gifs: gifs,
        totalPages: totalPages,
        currentPage: page,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: 'Erro na busca: ${e.toString()}',
      );
    }
  }

  Future<void> goToPage(int page) async {
    if (page < 1 || page > state.totalPages) return;
    if (state.currentQuery.isEmpty) {
      await fetchTrending(page: page);
    } else {
      await searchGifs(state.currentQuery, page: page);
    }
  }

  Future<void> nextPage() async {
    if (state.currentPage < state.totalPages) {
      await goToPage(state.currentPage + 1);
    }
  }

  Future<void> previousPage() async {
    if (state.currentPage > 1) {
      await goToPage(state.currentPage - 1);
    }
  }
}

final gifProvider = StateNotifierProvider<GifNotifier, GifState>((ref) {
  return GifNotifier(GiphyRemoteDataSource());
});
