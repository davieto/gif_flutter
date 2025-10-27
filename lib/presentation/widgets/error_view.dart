import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.message,
    this.onRetry,
  });

  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              message ?? 'Ocorreu um erro ao carregar os GIFs!',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 16),
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}