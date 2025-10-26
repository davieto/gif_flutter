import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF6F6F8),
    fontFamily: 'Roboto',
    colorSchemeSeed: Colors.purple,
  );

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0F0F12),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.pinkAccent,
      ),
      bodyMedium: TextStyle(
        color: Color(0xFFB3B3B3),
      ),
    ),
    colorSchemeSeed: Colors.purple,
  );
}