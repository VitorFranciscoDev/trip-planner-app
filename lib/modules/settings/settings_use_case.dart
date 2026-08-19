import 'package:flutter/material.dart';
import 'package:trip_planner/modules/settings/settings_spec.dart';

SettingsUseCase newSettingsUseCase(SettingsRepository settingsRepository) {
  return _SettingsUseCase(settingsRepository);
}

class _SettingsUseCase implements SettingsUseCase {
  const _SettingsUseCase(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  Future<Locale> getLanguage() async {
    return await _settingsRepository.getLanguage();
  }

  @override
  Future<ThemeMode> getTheme() async {
    return await _settingsRepository.getTheme();
  }
}
