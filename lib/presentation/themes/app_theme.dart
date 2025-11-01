import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeFromColor(String colorName, {bool isDark = false}) {
    final Color mainColor;

    switch (colorName) {
      case 'blue':
        mainColor = Colors.blueAccent;
        break;
      case 'green':
        mainColor = Colors.greenAccent;
        break;
      case 'purple':
        mainColor = Colors.deepPurpleAccent;
        break;
      default:
        mainColor = Colors.pinkAccent;
    }

    if (isDark) {
      return ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F12),
        colorScheme: ColorScheme.dark(
          primary: mainColor,
          surface: const Color(0xFF1A1A20),
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.black, foregroundColor: mainColor),
      );
    } else {
      return ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: mainColor,
          surface: Colors.grey.shade200,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      );
    }
  }
}