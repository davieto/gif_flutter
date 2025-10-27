import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/favorites_provider.dart';
import '../../application/state/gif_provider.dart';
import '../../application/state/preferences_provider.dart';
import '../widgets/gif_card.dart';
import '../widgets/loading_view.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final prefs = ref.watch(preferencesProvider);
    final gifsState = ref.watch(gifProvider);

    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum GIF favoritado ainda.\nVá em “Explorar” e favorite alguns!',
          textAlign: TextAlign.center,
        ),
      );
    }

    // GIFs favoritos visíveis
    final favoriteGifs = gifsState.gifs
        .where((g) => favorites.any((f) => f['id'] == g.id))
        .toList();

    if (favoriteGifs.isEmpty) {
      return const LoadingView(message: 'Carregando seus favoritos...');
    }

    // ajustar colunas conforme tamanho definido em Configurações
    int columns;
    double spacing;
    switch (prefs.size) {
      case 'small':
        columns = 6;
        spacing = 6;
        break;
      case 'large':
        columns = 2;
        spacing = 12;
        break;
      default:
        columns = 4;
        spacing = 8;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: favoriteGifs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemBuilder: (context, i) {
            final gif = favoriteGifs[i];
            return GifCard(
              imageUrl: gif.url,
              title: gif.title,
              isFavorite: true,
              onToggleFavorite: () =>
                  ref.read(favoritesProvider.notifier).toggleFavorite({
                        'id': gif.id,
                        'title': gif.title,
                        'url': gif.url,
                      }),
              onAddToCollection: () {},
              onOpenLightbox: () {},
            );
          },
        ),
      ),
    );
  }
}