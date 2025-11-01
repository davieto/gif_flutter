import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/collections_provider.dart';
import '../../application/state/preferences_provider.dart';
import 'collection_detail_page.dart';
import '../widgets/collection_dialog.dart';

class CollectionsPage extends ConsumerWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(collectionsProvider);
    final notifier = ref.read(collectionsProvider.notifier);
    final prefs = ref.watch(preferencesProvider);

    final primaryColor = Theme.of(context).colorScheme.primary;
    // final surface = Theme.of(context).colorScheme.surface; // ❌ Removido (não usado)

    int columns;
    switch (prefs.size) {
      case 'small':
        columns = 3;
        break;
      case 'large':
        columns = 1;
        break;
      default:
        columns = 2;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Coleções'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Nova coleção',
            onPressed: () async {
              await showCollectionDialog(context, ref, gifId: '');
            },
          ),
        ],
      ),
      body: collections.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma coleção criada ainda.\nAdicione GIFs a coleções para organizá-los!',
                textAlign: TextAlign.center,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.3,
                ),
                itemCount: collections.length,
                itemBuilder: (context, index) {
                  final c = collections[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CollectionDetailPage(collectionId: c.id),
                        ),
                      );
                    },
                    onLongPress: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Excluir coleção'),
                          content: Text(
                            'Tem certeza que deseja remover "${c.name}"?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('Excluir'),
                            ),
                          ],
                        ),
                      );

                      // ✅ Evita uso de context após await
                      if (!context.mounted) return;

                      if (confirmed == true) {
                        await notifier.deleteCollection(c.id);

                        if (!context.mounted) return; // segurança extra

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Coleção "${c.name}" foi removida com sucesso.',
                            ),
                            backgroundColor:
                                primaryColor.withValues(alpha: 0.9), // ✅ atualizado
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.15), // ✅ atualizado
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: primaryColor.withValues(alpha: 0.4), // ✅ atualizado
                          width: 1.2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.folder,
                              color: primaryColor,
                              size: 42,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              c.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${c.gifIds.length} GIFs',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.7), // ✅ atualizado
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}