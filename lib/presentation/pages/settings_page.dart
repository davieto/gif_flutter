import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../application/state/preferences_provider.dart';
import '../../application/state/favorites_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferencesProvider);
    final notifier = ref.read(preferencesProvider.notifier);

    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // Tema
          SwitchListTile(
            title: const Text('Modo escuro'),
            subtitle: const Text('Alterna entre tema claro e escuro'),
            value: prefs.isDark,
            onChanged: notifier.setTheme,
          ),
          const Divider(),

          // Reprodução automática
          SwitchListTile(
            title: const Text('Reprodução automática (autoplay)'),
            subtitle: const Text('Controla se os GIFs tocam automaticamente'),
            value: prefs.autoplay,
            onChanged: notifier.setAutoplay,
          ),
          const Divider(),

          // Idioma da API
          ListTile(
            title: const Text('Idioma dos resultados'),
            subtitle: const Text('Define o idioma usado nas buscas'),
            trailing: DropdownButton<String>(
              value: prefs.language,
              items: const [
                DropdownMenuItem(value: 'pt', child: Text('Português')),
                DropdownMenuItem(value: 'en', child: Text('Inglês')),
                DropdownMenuItem(value: 'es', child: Text('Espanhol')),
                DropdownMenuItem(value: 'fr', child: Text('Francês')),
              ],
              onChanged: (val) async {
                if (val != null) await notifier.setLanguage(val);
              },
            ),
          ),
          const Divider(),

          // Tamanho dos GIFs
          ListTile(
            title: const Text('Tamanho dos GIFs'),
            subtitle: const Text('Escolha o tamanho exibido no grid'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ToggleButtons(
              isSelected: [
                prefs.size == 'small',
                prefs.size == 'medium',
                prefs.size == 'large',
              ],
              onPressed: (index) async {
                switch (index) {
                  case 0:
                    await notifier.setGifSize('small');
                    break;
                  case 1:
                    await notifier.setGifSize('medium');
                    break;
                  case 2:
                    await notifier.setGifSize('large');
                    break;
                }
              },
              borderRadius: BorderRadius.circular(12),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Pequeno'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Médio'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Grande'),
                ),
              ],
            ),
          ),
          const Divider(),

          // Cor principal
          ListTile(
            title: const Text('Cor principal'),
            subtitle: const Text('Personalize a cor de destaque do aplicativo'),
            trailing: DropdownButton<String>(
              value: prefs.primaryColor,
              items: const [
                DropdownMenuItem(value: 'pink', child: Text('Rosa')),
                DropdownMenuItem(value: 'purple', child: Text('Roxo')),
                DropdownMenuItem(value: 'blue', child: Text('Azul')),
                DropdownMenuItem(value: 'green', child: Text('Verde')),
              ],
              onChanged: (val) async {
                if (val != null) await notifier.setColor(val);
              },
            ),
          ),
          const Divider(),

          // Limpar dados
          ListTile(
            title: const Text('Limpar dados locais'),
            subtitle: const Text('Remove histórico e favoritos armazenados'),
            trailing: ElevatedButton.icon(
              icon: const Icon(Icons.delete_outline),
              label: const Text('Limpar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor, // usa a cor do tema atual
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
              onPressed: () async {
                try {
                  final favBox = await Hive.openBox('favorites');
                  final histBox = await Hive.openBox('history');

                  await favBox.clear();
                  await histBox.clear();

                  // Atualiza estado na memória
                  ref.read(favoritesProvider.notifier).load();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                          'Favoritos e histórico removidos com sucesso!'),
                      backgroundColor: primaryColor.withOpacity(0.9),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao limpar dados: $e'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}