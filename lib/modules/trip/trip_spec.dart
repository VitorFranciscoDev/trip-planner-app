import 'package:trip_planner/entities/trip.dart';

// Trip's Contracts
abstract class ITripRepository {
  Future<int> addTrip(Trip trip);
  Future<int> deleteTrip(int id);
  Future<int> updateTrip(Trip trip);
  Future<List<Trip>?> getAllTrips(int user_id);
}