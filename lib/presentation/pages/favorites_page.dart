import 'package:flutter/material.dart';

/// Tela simples de exemplo. Posteriormente, conecta com ManageFavorites.
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(title: Text('Favoritos')),
      body: Center(child: Text('Nenhum favorito salvo.')),
    );
  }
}