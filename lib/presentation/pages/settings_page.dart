import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(themeProvider);
    final notifier = ref.read(themeProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Modo escuro'),
            value: dark,
            onChanged: (_) => notifier.toggleTheme(),
          ),
        ],
      ),
    );
  }
}