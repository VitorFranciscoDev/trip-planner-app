import 'package:flutter/material.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/modules/trip/trip_spec.dart';

// Trip's Use Cases
class TripUseCase {
  TripUseCase({ required this.tripRepository });

  final ITripRepository tripRepository;

  String? validateTripTitle(String tripTitle, BuildContext context) {
    final intl = AppLocalizations.of(context);

    return tripTitle.isEmpty ? intl.tripTitleRequired : null;
  }

  String? validateGroup(List<Person> group, BuildContext context) {
    final intl = AppLocalizations.of(context);

    return group.isEmpty ? intl.groupEmpty : null;
  }

  String? validateStops(List<Stop> stops, BuildContext context) {
    final intl = AppLocalizations.of(context);

    return stops.isEmpty ? intl.stopsEmpty : null;
  }

  Future<int> addTrip(Trip trip) async {
    try {
      // Returns the ID of Trip
      return await tripRepository.addTrip(trip);
    } catch (e) {
      throw Exception("Error in Add Trip Use Case: $e");
    }
  }

  Future<int> deleteTrip(int id) async {
    try {
      // Returns the number of rows affected
      return await tripRepository.deleteTrip(id);
    } catch (e) {
      throw Exception("Error in Delete Trip Use Case: $e");
    }
  }

  Future<int> updateTrip(Trip trip) async {
    try {
      // Returns the number of rows affected
      return await tripRepository.updateTrip(trip);
    } catch (e) {
      throw Exception("Error in Update Trip Use Case: $e");
    }
  }

  Future<List<Trip>?> getAllTrips(int user_id) async {
    try {
      // Returns User's Trips
      return await tripRepository.getAllTrips(user_id);
    } catch(e) {
      throw Exception("Error in Get All Trips Use Case: $e");
    }
  }
}