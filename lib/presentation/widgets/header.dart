import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String currentView;
  final Function(String) onNavigate;
  final int favoritesCount;
  final int collectionsCount;

  const Header({
    super.key,
    required this.currentView,
    required this.onNavigate,
    this.favoritesCount = 0,
    this.collectionsCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      title: Row(
        children: [
          const Icon(Icons.movie_filter_outlined, color: Colors.pinkAccent),
          const SizedBox(width: 8),
          Text(
            'GIFlix',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.trending_up),
          tooltip: 'Explorar',
          color: currentView == 'trending'
              ? Colors.pinkAccent
              : Colors.grey.shade300,
          onPressed: () => onNavigate('trending'),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.favorite),
              tooltip: 'Favoritos',
              color: currentView == 'favorites'
                  ? Colors.pinkAccent
                  : Colors.grey.shade300,
              onPressed: () => onNavigate('favorites'),
            ),
            if (favoritesCount > 0)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    favoritesCount.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.folder_open),
          tooltip: 'Coleções',
          color: currentView == 'collections'
              ? Colors.pinkAccent
              : Colors.grey.shade300,
          onPressed: () => onNavigate('collections'),
        ),
        IconButton(
          icon: const Icon(Icons.history),
          tooltip: 'Histórico',
          color: currentView == 'history'
              ? Colors.pinkAccent
              : Colors.grey.shade300,
          onPressed: () => onNavigate('history'),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Configurações',
          color: currentView == 'settings'
              ? Colors.pinkAccent
              : Colors.grey.shade300,
          onPressed: () => onNavigate('settings'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}