import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/gif_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gifProvider);
    final notifier = ref.read(gifProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Buscador de GIFs')),
      body: Center(
        child: state.loading
            ? const CircularProgressIndicator()
            : state.error != null
                ? Text('Erro: ${state.error}')
                : (state.gif == null)
                    ? const Text('Toque para buscar um GIF!')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(state.gif!.url),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(state.gif!.title),
                          ),
                        ],
                      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => notifier.fetchRandom(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}