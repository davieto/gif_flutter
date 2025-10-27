import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/collections_provider.dart';
import '../../application/state/preferences_provider.dart';
import '../widgets/gif_card.dart';

class CollectionDetailPage extends ConsumerWidget {
  final Collection collection;
  const CollectionDetailPage({super.key, required this.collection});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferencesProvider);

    int columns;
    switch (prefs.size) {
      case 'small':
        columns = 6;
        break;
      case 'large':
        columns = 2;
        break;
      default:
        columns = 4;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Coleção: ${collection.name}')),
      body: collection.gifIds.isEmpty
          ? Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.trending_up),
                label: const Text('Explorar GIFs'),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemCount: collection.gifIds.length,
              itemBuilder: (_, i) {
                final gifId = collection.gifIds[i];
                final gifUrl =
                    'https://media.giphy.com/media/$gifId/giphy.gif';
                return GifCard(
                  imageUrl: gifUrl,
                  title: gifId,
                  isFavorite: false,
                  onToggleFavorite: () {},
                  onAddToCollection: () {},
                  onOpenLightbox: () {},
                );
              },
            ),
    );
  }
}