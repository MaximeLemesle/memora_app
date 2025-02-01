import 'package:flutter/material.dart';

class CustomColors {
  static const Color primary50 = Color(0xFFf5f8f7);
  static const Color primary100 = Color(0xFFdee9e6);
  static const Color primary200 = Color(0xFFbcd3cd);
  static const Color primary300 = Color(0xFF92b6ad);
  static const Color primary400 = Color(0xFF6b968c);
  static const Color primary500 = Color(0xFF517b73);
  static const Color primary600 = Color(0xFF3f625c);
  static const Color primary700 = Color(0xFF334c48);
  static const Color primary800 = Color(0xFF2e413e);
  static const Color primary900 = Color(0xFF293836);
  static const Color primary950 = Color(0xFF141f1e);

  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF8F8F7);
  // static const Color neutral100 = Color(0xFFE8E9ED);
  static const Color neutral300 = Color(0xFFE6E7E4);
  static const Color neutral500 = Color(0xFF9C9E94);
  static const Color neutral700 = Color(0xFF4F5049);
  static const Color neutral900 = Color(0xFF1B1C17);

  static const Color success100 = Color(0xFFBBF7D0);
  static const Color success300 = Color(0xFF4ADE80);
  static const Color success500 = Color(0xFF22C55E);
  static const Color success700 = Color(0xFF15803D);

  static const Color warning100 = Color(0xFFFEF08A);
  static const Color warning300 = Color(0xFFFDE047);
  static const Color warning500 = Color(0xFFEAB308);
  static const Color warning700 = Color(0xFFCA8A04);

  static const Color error100 = Color(0xFFFECACA);
  static const Color error300 = Color(0xFFF87171);
  static const Color error500 = Color(0xFFEF4444);
  static const Color error700 = Color(0xFFB91C1C);
}

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: CustomColors.primary700,
    onPrimary: CustomColors.neutral0,
    secondary: CustomColors.primary500,
    error: CustomColors.error700,
    onError: CustomColors.error100,
    surface: CustomColors.neutral0,
    onSurface: CustomColors.neutral900,
    surfaceContainer: CustomColors.neutral50,
    surfaceContainerHighest: CustomColors.neutral700,
    outline: CustomColors.neutral300,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 42.0,
      fontFamily: 'Montserrat Alternates',
      fontWeight: FontWeight.w800,
    ),
    titleLarge: TextStyle(
      fontSize: 32.0,
      fontFamily: 'Montserrat Alternates',
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontSize: 24.0,
      fontFamily: 'Montserrat Alternates',
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontSize: 18.0,
      fontFamily: 'Montserrat Alternates',
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontFamily: 'DM Sans',
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontFamily: 'DM Sans',
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontFamily: 'DM Sans',
      fontWeight: FontWeight.w500,
    ),
    labelLarge: TextStyle(
      fontSize: 18.0,
      fontFamily: 'DM Sans',
      fontWeight: FontWeight.w700,
    ),
    labelMedium: TextStyle(
      fontSize: 16.0,
      fontFamily: 'DM Sans',
      fontWeight: FontWeight.w700,
    ),
    labelSmall: TextStyle(
      fontSize: 12.0,
      fontFamily: 'DM Sans',
      fontWeight: FontWeight.w700,
    ),
  ),
);
