import 'package:flutter/material.dart';

Future<void> showCollectionDialog(
  BuildContext context, {
  required List<Map<String, dynamic>> collections,
  required Function(String name) onCreateCollection,
  required Function(String id) onAddToCollection,
  required String selectedGifId,
}) async {
  final nameController = TextEditingController();
  bool creating = false;

  await showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) => AlertDialog(
        title: const Text('Adicionar à coleção'),
        content: creating
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(labelText: 'Nome da coleção'),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() => creating = false);
                            nameController.clear();
                          },
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Criar'),
                          onPressed: nameController.text.trim().isEmpty
                              ? null
                              : () {
                                  final c = nameController.text.trim();
                                  onCreateCollection(c);
                                  Navigator.pop(context);
                                },
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.create_new_folder_outlined),
                    label: const Text('Nova coleção'),
                    onPressed: () => setState(() => creating = true),
                  ),
                  const SizedBox(height: 8),
                  ...collections.map((c) {
                    final already = (c['gifIds'] as List)
                        .contains(selectedGifId); // exemplo de estrutura
                    return ListTile(
                      title: Text('${c['name']} (${c['gifIds'].length})'),
                      trailing: already
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap:
                          already ? null : () => onAddToCollection(c['id']),
                    );
                  }),
                ],
              ),
      ),
    ),
  );
}