import 'package:flutter/widgets.dart';
import 'package:trip_planner/entities/trip.dart';

class TripProvider with ChangeNotifier {
  List<Trip> trips = [];

  void addTrip(Trip trip) {
    trips.add(trip);
    notifyListeners();
  }

  void removeTrip(Trip trip) {
    trips.remove(trip);
    notifyListeners();
  }

}