import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final Function(String view) onNavigate;
  final String currentView;
  final int favoritesCount;
  final int collectionsCount;

  const Header({
    super.key,
    required this.onNavigate,
    required this.currentView,
    required this.favoritesCount,
    required this.collectionsCount,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('GIFlix'),
      actions: [
        IconButton(
          icon: const Icon(Icons.trending_up),
          onPressed: () => onNavigate('trending'),
        ),
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () => onNavigate('favorites'),
        ),
        IconButton(
          icon: const Icon(Icons.folder_open),
          onPressed: () => onNavigate('collections'),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'dark') {
              // trocar tema aqui
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'light', child: Text('Claro')),
            PopupMenuItem(value: 'dark', child: Text('Escuro')),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}