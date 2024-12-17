import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF3D3EAB),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFFECEFF3),
        onSecondary: Color(0xFF292A2D),
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF292A2D),
        primaryContainer: Color(0xFFE8E8FF),
        onPrimaryContainer: Color(0xFF3D3EAB),
        outlineVariant: Color(0xFFE3E9F4),
        surfaceContainerHigh: Color(0xFFECEFF3),
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF410002),
      ),
      useMaterial3: true,);

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    
    useMaterial3: true,
  );
}
