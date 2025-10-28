import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/gif_provider.dart';
import '../../application/state/favorites_provider.dart';
import '../widgets/header.dart';
import '../widgets/loading_view.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/gif_grid.dart';
import '../widgets/custom_search_bar.dart' as custom;
import '../widgets/collection_dialog.dart';
import 'favorites_page.dart';
import 'settings_page.dart';
import 'history_page.dart';
import 'collections_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String query = '';
  String currentView = 'trending';

  void _onNavigate(String view) {
    setState(() => currentView = view);
    if (view == 'trending') {
      ref.read(gifProvider.notifier).fetchTrending();
    }
  }

  @override
  void initState() {
    super.initState();
    Future(() => ref.read(gifProvider.notifier).fetchTrending());
  }

  @override
  Widget build(BuildContext context) {
    final gifState = ref.watch(gifProvider);
    final gifNotifier = ref.read(gifProvider.notifier);
    final favorites = ref.watch(favoritesProvider);

    Widget body;

    switch (currentView) {
      case 'favorites':
        body = const FavoritesPage();
        break;
      case 'collections':
        body = const CollectionsPage();
        break;
      case 'settings':
        body = const SettingsPage();
        break;
      case 'history':
        body = const HistoryPage();
        break;
      default:
        body = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(
            children: [
                custom.CustomSearchBar(
                onSearch: (value) {
                  setState(() => query = value);
                  gifNotifier.searchGifs(value);
                },
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (gifState.loading) return const LoadingView();
                    if (gifState.error != null) {
                      return ErrorView(
                        message: gifState.error,
                        onRetry: () => gifNotifier.fetchTrending(),
                      );
                    }
                    if (gifState.gifs.isEmpty) {
                      return const EmptyView(message: 'Nenhum GIF encontrado');
                    }
                    return GifGrid(
                      gifs: gifState.gifs
                          .map((g) => {
                                'id': g.id,
                                'url': g.url,
                                'title': g.title,
                              })
                          .toList(),
                      isFavorite: (id) => ref
                          .read(favoritesProvider.notifier)
                          .isFavorite(id),
                      onToggleFavorite: (gifMap) => ref
                          .read(favoritesProvider.notifier)
                          .toggleFavorite(gifMap),
                      onAddToCollection: (id) =>
                          showCollectionDialog(context, ref, gifId: id),
                      onOpenLightbox: (_) {},
                    );
                  },
                ),
              ),
            ],
          ),
        );
        break;
    }

    return Scaffold(
      appBar: Header(
        currentView: currentView,
        onNavigate: _onNavigate,
        favoritesCount: favorites.length,
        collectionsCount: 0,
      ),
      body: body,
    );
  }
}