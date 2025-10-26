import 'package:flutter/material.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';

// Stop's Use Cases
class StopUseCase {
  // Validation of Start Date
  String? validateStartDate(String startDate, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return startDate.isEmpty ? l10n.startDateRequired : null;
  }

  // Validation of End Date
  String? validateEndDate(String endDate, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return endDate.isEmpty ? l10n.endDateRequired : null;
  }

  // Date(String) => Date(DateTime)
  DateTime? parseDate(String text) { 
    try { 
      return DateTime.parse(text); 
    } catch(e) { 
      return null; 
    } 
  }

  // Validate both dates
  String? validateDates(String startDate, String endDate, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    DateTime? start = parseDate(startDate);
    DateTime? end = parseDate(endDate);

    if (start != null && end != null) {
      if (start.isAfter(end)) {
        return l10n.startAfterEnd;
      }
    }

    return null;
  }
}