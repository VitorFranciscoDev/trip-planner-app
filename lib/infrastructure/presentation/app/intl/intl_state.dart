import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntlProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';

  Locale _locale = const Locale('en', 'US');
  Locale get locale => _locale;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  IntlProvider() {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey);
      
      if (savedLanguage != null) {
        _locale = _getLocaleFromCode(savedLanguage);
      }
    } catch (e) {
      throw Exception("Error in Loading Language: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setLanguage(String languageCode) async {
    _locale = _getLocaleFromCode(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
    notifyListeners();
  }

  Locale _getLocaleFromCode(String code) {
    switch (code) {
      case 'en':
        return const Locale('en', 'US');
      case 'es':
        return const Locale('es', 'ES');
      case 'pt':
      default:
        return const Locale('pt', 'BR');
    }
  }
}