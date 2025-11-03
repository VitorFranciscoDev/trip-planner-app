import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF8B4513),
    secondary: const Color(0xFFFFA07A),
    tertiary: Colors.white,
    background: const Color(0xFFFFF8DC),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFD2B48C),
    secondary: Color(0xFFFFA07A),
    tertiary: Color(0xFF2E2A27),
    background: Color(0xFF1B1A17),
  ),
);
