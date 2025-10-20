import 'package:flutter/material.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';
import 'package:trip_planner/modules/trip/trip_spec.dart';

class TripUseCase {
  final ITripRepository tripRepository;

  TripUseCase({ required this.tripRepository });

  String? validateTripTitle(String tripTitle, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return tripTitle.isEmpty ? l10n.tripTitleRequired : null;
  }

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

  String? validateGroup(List<Person> group, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return group.isEmpty ? l10n.groupEmpty : null;
  }

  String? validateStops(List<Stop> stops, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return stops.isEmpty ? l10n.stopsEmpty : null;
  }

  Future<String?> createTrip(Trip trip, BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    
    try {
      final result = await tripRepository.registerTrip(trip);
      
      if (result > 0) {
        return null;
      }
      return l10n.tripCreateFailed;
    } catch (e) {
      return l10n.tripCreateError;
    }
  }

  Future<List<Trip>> getAllTrips() async {
    return await tripRepository.getAllTrips();
  }

  Future<Trip?> getTripById(int id) async {
    return await tripRepository.getTripById(id);
  }

  Future<String?> updateTrip(Trip trip, BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    
    try {
      final result = await tripRepository.updateTrip(trip);
      
      if (result > 0) {
        return null;
      }
      return l10n.tripCreateFailed;
    } catch (e) {
      return l10n.tripCreateError;
    }
  }

  Future<String?> deleteTrip(int id, BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    
    try {
      final result = await tripRepository.deleteTrip(id);
      
      if (result > 0) {
        return null;
      }
      return l10n.tripCreateFailed;
    } catch (e) {
      return l10n.tripCreateError;
    }
  }
}