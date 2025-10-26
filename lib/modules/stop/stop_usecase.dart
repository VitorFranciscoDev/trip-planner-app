import 'package:flutter/material.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';

class StopUseCase {
  String? validateStartDate(String startDate, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return startDate.isEmpty ? l10n.startDateRequired : null;
  }

  String? validateEndDate(String endDate, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return endDate.isEmpty ? l10n.endDateRequired : null;
  }

  DateTime? parseDate(String text) { 
    try { 
      return DateTime.parse(text); 
    } catch(e) { 
      return null; 
    } 
  }

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