import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/collections_provider.dart';
import '../widgets/collection_dialog.dart';

class CollectionsPage extends ConsumerWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(collectionsProvider);
    final notifier = ref.read(collectionsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Coleções'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Nova coleção',
            onPressed: () async {
              // Abre o diálogo de criação
              await showCollectionDialog(
                context,
                ref,
                gifId: '', // aqui só cria a coleção, sem adicionar GIF
              );
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.4,
                ),
                itemCount: collections.length,
                itemBuilder: (context, index) {
                  final c = collections[index];
                  return GestureDetector(
                    onTap: () {
                      // Aqui você pode abrir uma nova tela mostrando os GIFs dessa coleção
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Abrindo coleção: ${c.name}')),
                      );
                    },
                    onLongPress: () async {
                      // Pergunta se o usuário quer excluir
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Excluir coleção'),
                          content: Text(
                              'Tem certeza que deseja remover a coleção "${c.name}"?'),
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
                      if (confirmed == true) {
                        notifier.deleteCollection(c.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Coleção "${c.name}" removida.'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.pinkAccent.withOpacity(0.4),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.folder, color: Colors.pinkAccent, size: 40),
                            const SizedBox(height: 8),
                            Text(
                              c.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${c.gifIds.length} GIFs',
                              style: const TextStyle(
                                color: Colors.white70,
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