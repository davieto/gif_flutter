import 'package:flutter/material.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/themes/app_theme.dart';


void main() {
  runApp(const GifFlutterApp());
}

class GifFlutterApp extends StatelessWidget {
  const GifFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIFlix Flutter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const HomePage(), // 👈 NOVO FRONT
    );
  }
}