import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.deepPurple,
      surface: Colors.grey.shade200,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0F0F12),
    colorScheme: const ColorScheme.dark(
      primary: Colors.pinkAccent,
      surface: Color(0xFF1A1A20),
    ),
  );
}