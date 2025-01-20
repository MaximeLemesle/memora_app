import 'package:flutter/material.dart';

class AppTheme {
  // Couleurs d'accent
  static const Color tealGreen = Color(0xFF16B576);
  static const Color mustardYellow = Color(0xFFFCB446);
  static const Color pinkRose = Color(0xFFFA78E0);
  static const Color blueViolet = Color(0xFF7C6AF5);
  static const Color skyBlue = Color(0xFF69B6FF);
}

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
      primary: AppTheme.tealGreen,
      onPrimary: Colors.white,
      secondary: Color(0xFF9DA0AF),
      tertiary: Color(0xFF69B6FF),
      onTertiary: Color.fromARGB(255, 14, 21, 36),
      surface: Colors.white,
      onSurface: Color(0xFF0D0D0D),
      surfaceContainerHighest: Color(0xFFF6F7FB),
      outline: Color(0xFFD5D6DD),
      outlineVariant: Color(0xFF9C9FAE)),
  textTheme: TextTheme(
    /// Titre
    displayLarge: TextStyle(
      fontSize: 32,
      fontFamily: 'Dela Gothic One',
      color: Colors.grey.shade900,
      letterSpacing: .64,
    ),
    displayMedium: TextStyle(
      fontSize: 22,
      fontFamily: 'Dela Gothic One',
      color: Colors.grey.shade500,
      letterSpacing: .44,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontFamily: 'Dela Gothic One',
      color: Colors.grey.shade900,
      letterSpacing: .44,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontFamily: 'Dela Gothic One',
      color: Colors.grey.shade900,
      letterSpacing: .32,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontFamily: 'Dela Gothic One',
      color: Colors.grey.shade900,
      letterSpacing: .24,
    ),

    /// Sous-titre
    headlineLarge: TextStyle(
      fontSize: 18,
      fontFamily: 'Spline Sans Mono',
      color: Colors.grey.shade900,
    ),

    /// Texte
    bodyLarge: TextStyle(
      fontSize: 14,
      fontFamily: 'Spline Sans Mono',
      color: Colors.grey.shade900,
    ),
    bodyMedium: TextStyle(
      fontSize: 10,
      fontFamily: 'Spline Sans Mono',
      color: Colors.grey.shade900,
    ),
    bodySmall: TextStyle(
      fontSize: 8,
      fontFamily: 'Spline Sans Mono',
      color: Colors.grey.shade900,
    ),

    /// Texte gras
    labelLarge: TextStyle(
      fontSize: 14,
      fontFamily: 'Spline Sans Mono',
      color: Colors.grey.shade900,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      fontSize: 10,
      fontFamily: 'Spline Sans Mono',
      color: Colors.grey.shade900,
      fontWeight: FontWeight.bold,
    ),

    /// Bouton
    labelSmall: const TextStyle(
      fontSize: 10,
      fontFamily: 'Dela Gothic One',
      color: Colors.white,
      letterSpacing: .20,
    ),
  ),
);