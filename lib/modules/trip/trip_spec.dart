import 'package:trip_planner/entities/trip.dart';

abstract class ITripRepository {
  Future<int> registerTrip(Trip trip);
  Future<List<Trip>> getAllTrips();
  Future<Trip?> getTripById(int id);
  Future<int> updateTrip(Trip trip);
  Future<int> deleteTrip(int id);
}