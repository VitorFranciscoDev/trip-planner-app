import 'package:flutter/material.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';
import 'package:trip_planner/modules/trip/trip_spec.dart';

// Trip's Use Cases
class TripUseCase {
  TripUseCase({ required this.tripRepository });

  final ITripRepository tripRepository; // Repository

  // Validation of Trip Title
  String? validateTripTitle(String tripTitle, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return tripTitle.isEmpty ? l10n.tripTitleRequired : null;
  }

  // Validation of Group
  String? validateGroup(List<Person> group, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return group.isEmpty ? l10n.groupEmpty : null;
  }

  // Validation of Stops
  String? validateStops(List<Stop> stops, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return stops.isEmpty ? l10n.stopsEmpty : null;
  }

  // Add Trip
  Future<int> addTrip(Trip trip) async {
    try {
      return await tripRepository.addTrip(trip);
    } catch (e) {
      throw Exception("Error in Add Trip Use Case: $e");
    }
  }

  // Delete Trip
  Future<int> deleteTrip(int id) async {
    try {
      return await tripRepository.deleteTrip(id);
    } catch (e) {
      throw Exception("Error in Delete Trip Use Case: $e");
    }
  }

  // Update Trip
  Future<int> updateTrip(Trip trip) async {
    try {
      return await tripRepository.updateTrip(trip);
    } catch (e) {
      throw Exception("Error in Update Trip Use Case: $e");
    }
  }

  // Get All Trips
  Future<List<Trip>?> getAllTrips(int user_id) async {
    try {
      return await tripRepository.getAllTrips(user_id);
    } catch(e) {
      throw Exception("Error in Get All Trips Use Case: $e");
    }
  }
}