import 'package:flutter/material.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';
import 'package:trip_planner/modules/person/person_spec.dart';

// Person's Use Cases
class PersonUseCase {
  PersonUseCase({ required this.personRepository });

  final IPersonRepository personRepository;

  // Validation of Name
  String? validateName(String name, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return name.isEmpty ? l10n.nameRequired : null;
  }

  // Validation of Age
  String? validateAge(String age, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    if (age.isEmpty) return l10n.ageRequired;
    
    if (!RegExp(r'^[0-9]+$').hasMatch(age)) return l10n.ageInvalid;
    
    return null;
  }

  Future<int> updatePerson(Person person) async {
    try {
      return await personRepository.updatePerson(person);
    } catch(e) {
      throw Exception("Error in Update Person Use Case: $e");
    }
  }
}