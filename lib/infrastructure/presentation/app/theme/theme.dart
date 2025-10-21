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
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFF5A3410),
    secondary: const Color(0xFFFF8C69),
    tertiary: const Color(0xFF2E2E2E),
    background: const Color(0xFF121212),
  ),
);