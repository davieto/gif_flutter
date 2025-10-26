import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'gif_card.dart';

class GifGrid extends StatelessWidget {
  final List<Map<String, dynamic>> gifs;
  final bool Function(String id) isFavorite;
  final Function(String id) onToggleFavorite;
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
  Widget build(BuildContext context) {
    if (gifs.isEmpty) {
      return const Center(child: Text('Nenhum GIF encontrado.'));
    }

    return MasonryGridView.count(
      crossAxisCount: MediaQuery.of(context).size.width > 1200
          ? 4
          : MediaQuery.of(context).size.width > 800
              ? 3
              : MediaQuery.of(context).size.width > 500
                  ? 2
                  : 1,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      padding: const EdgeInsets.only(top: 8),
      itemCount: gifs.length,
      itemBuilder: (context, index) {
        final gif = gifs[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: GifCard(
            imageUrl: gif['url'] ?? '',
            title: gif['title'] ?? '',
            isFavorite: isFavorite(gif['id']),
            onToggleFavorite: () => onToggleFavorite(gif['id']),
            onAddToCollection: () => onAddToCollection(gif['id']),
            onOpenLightbox: () => onOpenLightbox(gif['id']),
          ),
        );
      },
    );
  }
}