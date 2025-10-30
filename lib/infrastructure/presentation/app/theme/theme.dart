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
    primary: const Color(0xFF8B4513),
    secondary: const Color.fromARGB(255, 255, 133, 84),
    tertiary: const Color.fromARGB(255, 41, 41, 41),
    background: const Color.fromARGB(255, 23, 18, 18),
  ),
);