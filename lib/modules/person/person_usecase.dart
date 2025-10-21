import 'package:flutter/material.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';

class PersonUseCase {
  String? validateName(String name, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return name.isEmpty ? l10n.nameRequired : null;
  }

  String? validateAge(String age, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    if (age.isEmpty) return l10n.ageRequired;
    
    if (!RegExp(r'^[0-9]+$').hasMatch(age)) return l10n.ageInvalid;
    
    return null;
  }
}