import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/modules/person/person_usecase.dart';
import 'package:trip_planner/modules/stop/stop_usecase.dart';
import 'package:trip_planner/modules/trip/trip_usecase.dart';

class TripProvider extends ChangeNotifier {
  TripProvider({ required this.tripUseCase, required this.personUseCase, required this.stopUseCase });

  final TripUseCase tripUseCase;
  final PersonUseCase personUseCase;
  final StopUseCase stopUseCase;

  Trip? _trip;
  Trip? get trip => _trip;
  set trip(Trip? newTrip) {
    _trip = newTrip;
    notifyListeners();
  }

  List<Trip> _trips = [];
  List<Trip> get trips => _trips;

  List<Person> _group = [];
  List<Person> get group => _group;
  set group(List<Person> newGroup) {
    _group = newGroup;
    notifyListeners();
  }

  List<Stop> _stops = [];
  List<Stop> get stops => _stops;
  set stops(List<Stop> newStops) {
    _stops = newStops;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

    notifyListeners();

    return _errorTripTitle == null && _errorGroup == null && _errorStops == null;
  }

  bool validatePerson(String name, String age, BuildContext context) {
    _errorName = personUseCase.validateName(name, context);
    _errorAge = personUseCase.validateAge(age, context);

    notifyListeners();

    return _errorName == null && _errorAge == null;
  }

  bool validateStopDates(String startDate, String endDate, BuildContext context) {
    _errorStartDate = stopUseCase.validateStartDate(startDate, context);
    _errorEndDate = stopUseCase.validateEndDate(endDate, context);

    if(_errorStartDate == null && _errorEndDate == null) {
      _errorStartDate = stopUseCase.validateDates(startDate, endDate, context);
      _errorEndDate = stopUseCase.validateDates(startDate, endDate, context);
    }

    notifyListeners();

    return _errorStartDate == null && _errorEndDate == null;
  }

  Future<String?> addTrip(Trip trip, BuildContext context) async {
    final intl = AppLocalizations.of(context);
    _isLoading = true;
    notifyListeners();

    try {
      // Receives index of new User
      final result = await tripUseCase.addTrip(trip);

      if(result > 0) return null;
      return intl.error;
    } catch(e) {
      return intl.unexpectedError;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> deleteTrip(int? id, BuildContext context) async {
    final intl = AppLocalizations.of(context);
    _isLoading = true;
    notifyListeners();

    try {
      final result = await tripUseCase.deleteTrip(id!);

      if(result > 0) return null;
      return intl.error;
    } catch(e) {
      return intl.unexpectedError;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> updateTrip(Trip trip, BuildContext context) async {
    final intl = AppLocalizations.of(context);
    _isLoading = true;
    notifyListeners();

    try {
      final result = await tripUseCase.updateTrip(trip);

      if(result > 0) return null;
      return intl.error;
    } catch(e) {
      return intl.unexpectedError;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAllTrips(int? user_id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final allTrips = await tripUseCase.getAllTrips(user_id!);

      if(allTrips != null) {
        _trips = allTrips;
        notifyListeners();
      }
    } catch(e) {
      _trips = [];
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

  void deleteStop(int index) {
    _stops.removeAt(index);
    notifyListeners();
  }

  void updateStop(int index, Stop stop) {
    _stops[index] = stop;
    notifyListeners();
  }

  Future<String?> getAddressFromCoordinates(LatLng position) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Returns address
      return await stopUseCase.getAddressFromCoordinates(position);
    } catch(e) {
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<LatLng>> getRoute(List<LatLng> points) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Returns route
      return stopUseCase.getRoute(points);
    } catch(e) {
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    
  }
}