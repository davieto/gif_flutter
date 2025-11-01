import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/themes/app_theme.dart';
import 'application/state/preferences_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('preferences');
  await Hive.openBox('favorites');
  await Hive.openBox('collections');
  await Hive.openBox('history');

  runApp(const ProviderScope(child: GifFlutterApp()));
}

class GifFlutterApp extends ConsumerWidget {
  const GifFlutterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferencesProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GiGif',
      theme: AppTheme.themeFromColor(prefs.primaryColor, isDark: false),
      darkTheme: AppTheme.themeFromColor(prefs.primaryColor, isDark: true),
      themeMode: prefs.isDark ? ThemeMode.dark : ThemeMode.light,
      home: const HomePage(),
    );
  }
}