import 'package:flutter/material.dart';

/// Interface for managing settings actions.
abstract class SettingsRepository {
  /// Returns the saved language preference.
  Future<Locale> getLanguage();

  /// Returns the saved theme preference.
  Future<ThemeMode> getTheme();
}

/// Interface for managing settings actions.
abstract class SettingsUseCase {
  /// Returns the saved language preference.
  Future<Locale> getLanguage();

  /// Returns the saved theme preference.
  Future<ThemeMode> getTheme();
}
