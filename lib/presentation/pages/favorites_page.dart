import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/favorites_provider.dart';
import '../../application/state/preferences_provider.dart';
import '../widgets/collection_dialog.dart';
import '../widgets/gif_card.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final prefs = ref.watch(preferencesProvider);

    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum GIF favoritado ainda.\nVá em “Explorar” e favorite alguns!',
          textAlign: TextAlign.center,
        ),
      );
    }

    final favoriteGifs = favorites;

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
              imageUrl: gif['url'],
              title: gif['title'],
              isFavorite: true,
              onToggleFavorite: () =>
                  ref.read(favoritesProvider.notifier).toggleFavorite(gif),
              onAddToCollection: () =>
                  showCollectionDialog(context, ref, gifId: gif['id']),
              onOpenLightbox: () {},
            );
          },
        ),
      ),
    );
  }
}
