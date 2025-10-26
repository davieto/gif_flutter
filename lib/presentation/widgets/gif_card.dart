import 'package:flutter/material.dart';

class GifCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onAddToCollection;
  final VoidCallback onOpenLightbox;

  const GifCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onAddToCollection,
    required this.onOpenLightbox,
  });

  @override
  State<GifCard> createState() => _GifCardState();
}

class _GifCardState extends State<GifCard> {
  bool hovered = false;
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: widget.onOpenLightbox,
        child: AnimatedScale(
          scale: hovered ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    loaded = true;
                    return child;
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              if (hovered && loaded)
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black87, Colors.transparent],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            color: widget.isFavorite ? Colors.red : Colors.white,
                            onPressed: widget.onToggleFavorite,
                            icon: const Icon(Icons.favorite),
                          ),
                          IconButton(
                            color: Colors.white,
                            onPressed: widget.onAddToCollection,
                            icon: const Icon(Icons.add_box_outlined),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}