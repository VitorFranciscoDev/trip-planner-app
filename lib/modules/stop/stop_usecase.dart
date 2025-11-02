import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/modules/stop/stop_spec.dart';

// Stop's Use Cases
class StopUseCase {
  StopUseCase({ required this.stopRepository });

  final IStopRepository stopRepository;

  // Validation of Start Date
  String? validateStartDate(String startDate, BuildContext context) {
    final intl = AppLocalizations.of(context);

    return startDate.isEmpty ? intl.startDateRequired : null;
  }

  // Validation of End Date
  String? validateEndDate(String endDate, BuildContext context) {
    final intl = AppLocalizations.of(context);

    return endDate.isEmpty ? intl.endDateRequired : null;
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
    final intl = AppLocalizations.of(context);
    DateTime? start = parseDate(startDate);
    DateTime? end = parseDate(endDate);

    if (start != null && end != null) {
      if (start.isAfter(end)) {
        return intl.endDate;
      }
    }

    return null;
  }

  // Get Address based on Coordinates(lat, lng) from Repository
  Future<String?> getAddressFromCoordinates(LatLng position) async {
    try {
      return await stopRepository.getAddressFromCoordinates(position);
    } catch (e) {
      throw Exception("Error in Get Address From Coordinates Use Case: $e");
    }
  }

  // Get Map Routes from Repository
  Future<List<LatLng>> getRoute(List<LatLng> points) async {
    try {
      return await stopRepository.getRoute(points);
    } catch(e) {
      throw Exception("Error in Get Route Use Case: $e");
    }
  } 
}