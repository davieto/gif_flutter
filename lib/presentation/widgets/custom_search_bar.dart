import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../application/state/history_provider.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  final Function(String query) onSearch;
  const CustomSearchBar({super.key, required this.onSearch});

  @override
  ConsumerState<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    final historyBox = Hive.box('history');
    final suggestions =
        historyBox.values.cast<String>().toList().reversed.toList();

    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) return const Iterable<String>.empty();
        return suggestions.where((option) => option
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (value) {
        widget.onSearch(value);
        ref.read(historyProvider.notifier).addSearch(value);
      },
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onSubmitted: (value) {
            widget.onSearch(value);
            ref.read(historyProvider.notifier).addSearch(value);
          },
          decoration: InputDecoration(
            hintText: 'Buscar GIFs...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      },
    );
  }
}