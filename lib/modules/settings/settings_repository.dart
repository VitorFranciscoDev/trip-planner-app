import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_planner/modules/settings/settings_spec.dart';

SettingsRepository newSettingsRepository(SharedPreferences preferences) {
  return _SettingsRepository(preferences);
}

class _SettingsRepository implements SettingsRepository {
  const _SettingsRepository(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<Locale> getLanguage() async {
    final language = _preferences.getString('language');
    if (language == null) {
      return Locale('');
    }

    return Locale('');
  }

  @override
  Future<ThemeMode> getTheme() async {
    final theme = _preferences.getString('theme');
    if (theme == null) {
      return ThemeMode.system;
    }

    return ThemeMode.system;
  }
}
