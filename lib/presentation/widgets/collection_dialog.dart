import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/collections_provider.dart';

Future<void> showCollectionDialog(
  BuildContext context,
  WidgetRef ref, {
  required String gifId,
}) async {
  final collections = ref.watch(collectionsProvider);
  final notifier = ref.read(collectionsProvider.notifier);
  final controller = TextEditingController();
  bool creating = false;

  await showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) => AlertDialog(
        title: const Text('Adicionar à coleção'),
        content: creating
            ? TextField(
                controller: controller,
                decoration:
                    const InputDecoration(labelText: 'Nome da nova coleção'),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    notifier.createCollection(value);
                    setState(() => creating = false);
                  }
                },
              )
            : SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.create_new_folder),
                      label: const Text('Nova coleção'),
                      onPressed: () => setState(() => creating = true),
                    ),
                    const Divider(),
                    ...collections.map((c) {
                      return ListTile(
                        title: Text(c.name),
                        trailing: Text('${c.gifIds.length} GIFs'),
                        onTap: () {
                          notifier.addGif(c.id, gifId);
                          Navigator.pop(ctx);
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
      ),
    ),
  );
}