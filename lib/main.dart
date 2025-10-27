import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'data/database/app_database.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/themes/app_theme.dart';
import 'application/state/preferences_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o driver SQLite da Web, caso esteja rodando no navegador
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }

  // Garante que o banco foi aberto antes de iniciar o app
  await AppDatabase.instance.database;

  runApp(const ProviderScope(child: GifFlutterApp()));
}

class GifFlutterApp extends ConsumerWidget {
  const GifFlutterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferencesProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GIFlix Flutter',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: prefs.isDark ? ThemeMode.dark : ThemeMode.light,
      home: const HomePage(),
    );
  }
}