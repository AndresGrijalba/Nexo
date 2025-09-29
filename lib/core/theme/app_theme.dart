import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData light(Color mainColor) {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: mainColor,
        secondary: mainColor,
      ),
      fontFamily: 'Inter',

    );
  }

  static ThemeData dark (Color mainColor) {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: mainColor,
        secondary: mainColor,
      ),
      fontFamily: 'Inter',
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1A1A1A),
      ),
    );
  }
}