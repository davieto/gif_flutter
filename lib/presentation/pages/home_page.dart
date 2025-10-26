import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/search_bar.dart' as custom;
import '../widgets/gif_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String view = 'trending';
  String searchQuery = '';
  List<Map<String, dynamic>> gifs = [];

  @override
  void initState() {
    super.initState();
    gifs = [
      {
        'id': '1',
        'title': 'Cat',
        'url':
            'https://media.giphy.com/media/JIX9t2j0ZTN9S/giphy.gif',
        'gifIds': [],
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        onNavigate: (v) => setState(() => view = v),
        currentView: view,
        favoritesCount: 2,
        collectionsCount: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          custom.SearchBar(onSearch: (q) => setState(() => searchQuery = q)),
            const SizedBox(height: 12),
            Expanded(
              child: GifGrid(
                gifs: gifs,
                isFavorite: (_) => false,
                onToggleFavorite: (_) {},
                onAddToCollection: (_) {},
                onOpenLightbox: (_) {},
              ),
            )
          ],
        ),
      ),
    );
  }
}