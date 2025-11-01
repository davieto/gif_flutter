import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/collections_provider.dart';
import '../../application/state/preferences_provider.dart';
import '../../application/state/favorites_provider.dart';
import '../widgets/collection_dialog.dart';
import '../widgets/gif_card.dart';

class CollectionDetailPage extends ConsumerWidget {
  final String collectionId;
  const CollectionDetailPage({super.key, required this.collectionId});

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

    final favorites = ref.watch(favoritesProvider);
    final collections = ref.watch(collectionsProvider);
    final collection = collections.where((c) => c.id == collectionId).isNotEmpty
        ? collections.firstWhere((c) => c.id == collectionId)
        : null;

    if (collection == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Coleção')),
        body: const Center(child: Text('Coleção não encontrada.')),
      );
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
                final gifUrl = 'https://media.giphy.com/media/$gifId/giphy.gif';
                final notifier = ref.read(collectionsProvider.notifier);
                return Stack(
                  children: [
                    GifCard(
                      imageUrl: gifUrl,
                      title: gifId,
                      isFavorite: favorites.any((f) => f['id'] == gifId),
                      onToggleFavorite: () =>
                          ref.read(favoritesProvider.notifier).toggleFavorite({
                            'id': gifId,
                            'title': gifId,
                            'url': gifUrl,
                          }),
                      onAddToCollection: () =>
                          showCollectionDialog(context, ref, gifId: gifId),
                      onOpenLightbox: () {},
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                          tooltip: 'Remover da coleção',
                          onPressed: () async {
                            await notifier.removeGif(collection.id, gifId);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('GIF removido da coleção'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
