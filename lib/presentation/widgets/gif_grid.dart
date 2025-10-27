import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'gif_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/preferences_provider.dart';

class GifGrid extends ConsumerWidget {
  final List<Map<String, dynamic>> gifs;
  final bool Function(String id) isFavorite;
  final Function(Map<String, dynamic> gif) onToggleFavorite;
  final Function(String id) onAddToCollection;
  final Function(String id) onOpenLightbox;

  const GifGrid({
    super.key,
    required this.gifs,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onAddToCollection,
    required this.onOpenLightbox,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferencesProvider);
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

    if (gifs.isEmpty) {
      return const Center(child: Text('Nenhum GIF encontrado.'));
    }

    return MasonryGridView.count(
      crossAxisCount: columns,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      itemCount: gifs.length,
      itemBuilder: (context, index) {
        final gif = gifs[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: GifCard(
            imageUrl: gif['url'],
            title: gif['title'],
            isFavorite: isFavorite(gif['id']),
            onToggleFavorite: () => onToggleFavorite(gif),
            onAddToCollection: () => onAddToCollection(gif['id']),
            onOpenLightbox: () => onOpenLightbox(gif['id']),
          ),
        );
      },
    );
  }
}