import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  static const String themeKey = "theme_mode";

  ThemeProvider() {
    loadTheme();
  }

  void toggleTheme(bool darkTheme) {
    themeMode = darkTheme ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  saveTheme(bool darkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, darkTheme);
  }

  loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final darkTheme = prefs.getBool(themeKey);
    
    if (darkTheme != null) {
      themeMode = darkTheme ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }
}