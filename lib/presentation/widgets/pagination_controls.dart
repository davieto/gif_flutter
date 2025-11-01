import 'package:flutter/material.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPreviousPage,
    required this.onNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: currentPage > 1 ? onPreviousPage : null,
          icon: const Icon(Icons.arrow_back),
          label: const Text('Anterior'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Página $currentPage de $totalPages',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ElevatedButton.icon(
          onPressed: currentPage < totalPages ? onNextPage : null,
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Próxima'),
        ),
      ],
    );
  }
}
