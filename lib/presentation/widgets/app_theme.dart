import 'package:flutter/material.dart';

class GifTile extends StatelessWidget {
  final String url;
  final String title;

  const GifTile({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Container(
        color: Colors.black54,
        padding: const EdgeInsets.all(4),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      child: Image.network(url, fit: BoxFit.cover),
    );
  }
}