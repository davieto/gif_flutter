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
    final primaryColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade400
        : Colors.grey.shade300;

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      title: Row(
        children: [
          Icon(
            Icons.movie_filter_outlined,
            color: primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            'GIFlix',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.trending_up),
          tooltip: 'Explorar',
          color: currentView == 'trending' ? primaryColor : inactiveColor,
          onPressed: () => onNavigate('trending'),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.favorite),
              tooltip: 'Favoritos',
              color: currentView == 'favorites' ? primaryColor : inactiveColor,
              onPressed: () => onNavigate('favorites'),
            ),
            if (favoritesCount > 0)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: primaryColor,
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
          color: currentView == 'collections' ? primaryColor : inactiveColor,
          onPressed: () => onNavigate('collections'),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Configurações',
          color: currentView == 'settings' ? primaryColor : inactiveColor,
          onPressed: () => onNavigate('settings'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}