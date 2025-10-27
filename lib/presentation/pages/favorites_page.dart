import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/favorites_provider.dart';
import '../../application/state/gif_provider.dart';
import '../widgets/gif_card.dart';
import '../widgets/loading_view.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final gifsState = ref.watch(gifProvider);

    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum GIF favoritado ainda. Vá em “Explorar” e favorite alguns!',
          textAlign: TextAlign.center,
        ),
      );
    }

    // Exibe apenas GIFs favoritos que ainda estão com info carregada
    final favoriteGifs = gifsState.gifs
        .where((g) => favorites.contains(g.id))
        .toList();

    if (favoriteGifs.isEmpty) {
      // se ainda não carregou gifs recentes, pode mostrar um progress
      return const LoadingView(message: 'Carregando seus favoritos...');
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: favoriteGifs.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, i) {
          final gif = favoriteGifs[i];
          return GifCard(
            imageUrl: gif.url,
            title: gif.title,
            isFavorite: true,
            onToggleFavorite: () =>
                ref.read(favoritesProvider.notifier).toggleFavorite(gif.id),
            onAddToCollection: () {},
            onOpenLightbox: () {},
          );
        },
      ),
    );
  }
}