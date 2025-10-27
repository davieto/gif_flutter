import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/history_provider.dart';

class SearchBar extends ConsumerStatefulWidget {
  final Function(String query) onSearch;
  const SearchBar({super.key, required this.onSearch});

  @override
  ConsumerState<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Buscar GIFs...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onSubmitted: (value) {
        widget.onSearch(value);
        ref.read(historyProvider.notifier).addSearch(value);
      },
    );
  }
}