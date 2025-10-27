import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/themes/app_theme.dart';
import 'application/state/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: GifFlutterApp()));
}

class GifFlutterApp extends ConsumerWidget {
  const GifFlutterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GIFlix Flutter',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: const HomePage(),
    );
  }
}