import 'package:flutter/material.dart';
import '../../core/utils/debouncer.dart';

class SearchBar extends StatefulWidget {
  final Function(String query) onSearch;

  const SearchBar({super.key, required this.onSearch});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 300));
  bool showSuggestions = false;
  List<String> suggestions = [];

  Future<void> loadSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() => suggestions = []);
      return;
    }

    // mock de busca — substitua por sua API Giphy
    suggestions = ['dog', 'cat', 'funny', 'dance']
        .where((s) => s.contains(query.toLowerCase()))
        .toList();

    setState(() => showSuggestions = suggestions.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Buscar GIFs...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _controller.clear();
                widget.onSearch('');
              },
            ),
          ),
          onChanged: (val) => _debouncer.run(() => loadSuggestions(val)),
          onSubmitted: (val) {
            widget.onSearch(val);
            setState(() => showSuggestions = false);
          },
        ),
        if (showSuggestions)
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: ListView(
              shrinkWrap: true,
              children: suggestions
                  .map(
                    (s) => ListTile(
                      title: Text(s),
                      onTap: () {
                        _controller.text = s;
                        widget.onSearch(s);
                        setState(() => showSuggestions = false);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}