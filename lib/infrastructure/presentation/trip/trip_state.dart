import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/modules/person/person_usecase.dart';
import 'package:trip_planner/modules/stop/stop_usecase.dart';
import 'package:trip_planner/modules/trip/trip_usecase.dart';

class TripProvider extends ChangeNotifier {
  // Constructor
  TripProvider({ required this.tripUseCase, required this.personUseCase, required this.stopUseCase });

  // Use Cases
  final TripUseCase tripUseCase;
  final PersonUseCase personUseCase;
  final StopUseCase stopUseCase;

  // Trip Data
  Trip? _trip;
  Trip? get trip => _trip;
  set trip(Trip? newTrip) {
    _trip = newTrip;
    notifyListeners();
  }

  // List of Trips
  List<Trip> _trips = [];
  List<Trip> get trips => _trips;

  // Group Data
  List<Person> _group = [];
  List<Person> get group => _group;

  // Stops Data
  List<Stop> _stops = [];
  List<Stop> get stops => _stops;
  set stops(List<Stop> newStops) {
    _stops = newStops;
    notifyListeners();
  }

  // Loading boolean
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Errors
  String? _errorTripTitle;
  String? _errorName;
  String? _errorAge;
  String? _errorGroup;
  String? _errorStartDate;
  String? _errorEndDate;
  String? _errorStops;

  String? get errorTripTitle => _errorTripTitle;
  String? get errorName => _errorName;
  String? get errorAge => _errorAge;
  String? get errorGroup => _errorGroup;
  String? get errorStartDate => _errorStartDate;
  String? get errorEndDate => _errorEndDate;
  String? get errorStops => _errorStops;

  bool validateTrip(String title, BuildContext context) {
    _errorTripTitle = tripUseCase.validateTripTitle(title, context);
    _errorGroup = tripUseCase.validateGroup(_group, context);
    _errorStops = tripUseCase.validateStops(_stops, context);

    return _errorTripTitle == null && _errorGroup == null && _errorStops == null;
  }

  bool validatePerson(String name, String age, BuildContext context) {
    _errorName = personUseCase.validateName(name, context);
    _errorAge = personUseCase.validateAge(age, context);

    return _errorName == null && _errorAge == null;
  }

  bool validateStopDates(String startDate, String endDate) {
    _errorStartDate = stopUseCase.validateStartDate(startDate);
    _errorEndDate = stopUseCase.validateEndDate(endDate);
    if(_errorStartDate == null && _errorEndDate == null) {
      _errorStartDate = stopUseCase.validateDates(startDate, endDate);
      _errorEndDate = stopUseCase.validateDates(startDate, endDate);
    }

    return _errorStartDate == null && _errorEndDate == null;
  }

  Future<String?> addTrip(Trip trip) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await tripUseCase.addTrip(trip);

      if(result > 0) return null;
      return "Error in Adding Trip";
    } catch(e) {
      return "Unexpected Error. Try Again.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> deleteTrip(int? id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await tripUseCase.deleteTrip(id!);

      if(result > 0) return null;
      return "Error in Deleting Trip";
    } catch(e) {
      return "Unexpected Error. Try Again.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> updateTrip(Trip trip) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await tripUseCase.updateTrip(trip);

      if(result > 0) return null;
      return "Error in Updating Trip";
    } catch(e) {
      return "Unexpected Error. Try Again";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> getAllTrips(int? user_id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final allTrips = await tripUseCase.getAllTrips(user_id!);

      if(allTrips != null) {
        _trips = allTrips;
        notifyListeners();
        return null;
      }

      return "Error in Getting Trips";
    } catch(e) {
      return "Unexpected Error. Try Again.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addPerson(Person person) {
    _group.add(person);
    notifyListeners();
  }

  void deletePerson(Person person) {
    _group.remove(person);
    notifyListeners();
  }

  void addStop(Stop stop) {
    _stops.add(stop);
    notifyListeners();
  }

  void deleteStop(Stop stop) {
    _stops.remove(stop);
    notifyListeners();
  }

  Future<String?> getAddressFromCoordinates(LatLng position) async {
    try {
      return await stopUseCase.getAddressFromCoordinates(position);
    } catch(e) {
      return "Unexpected Error. Try Again.";
    }
  }

  Future<List<LatLng>> getRoute(List<LatLng> points) async {
    return stopUseCase.getRoute(points);
  }
}