import 'package:flutter/material.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';

// Person's Use Cases
class PersonUseCase {
  String? validateName(String name, BuildContext context) {
    final intl = AppLocalizations.of(context);

    return name.isEmpty ? intl.nameRequired : null;
  }

  String? validateAge(String age, BuildContext context) {
    final intl = AppLocalizations.of(context);
    
    if (age.isEmpty) return intl.ageRequired;
    
    if (!RegExp(r'^[0-9]+$').hasMatch(age)) return intl.ageInvalid;
    
    return null;
  }
}