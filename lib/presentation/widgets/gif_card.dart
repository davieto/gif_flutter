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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          widget.title,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              widget.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: widget.isFavorite
                                  ? Colors.redAccent
                                  : Colors.white,
                            ),
                            onPressed: widget.onToggleFavorite,
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.add_box_outlined),
                            tooltip: 'Adicionar à coleção',
                            onPressed: widget.onAddToCollection,
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