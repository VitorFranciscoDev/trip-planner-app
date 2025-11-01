import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    loadTheme();
  }

  static const String themeKey = "theme_mode";

  ThemeMode themeMode = ThemeMode.light;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> toggleTheme(bool darkTheme) async {
    themeMode = darkTheme ? ThemeMode.dark : ThemeMode.light;
    await saveTheme(darkTheme);
    notifyListeners();
  }

  Future<void> saveTheme(bool darkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, darkTheme);
  }

  Future<void> loadTheme() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final darkTheme = prefs.getBool(themeKey) ?? false;
      
      themeMode = darkTheme ? ThemeMode.dark : ThemeMode.light;
    } catch (e) {
      themeMode = ThemeMode.light;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}