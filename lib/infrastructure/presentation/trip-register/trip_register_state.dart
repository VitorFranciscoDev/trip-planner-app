import 'package:flutter/material.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/modules/trip/trip_usecase.dart';
import 'package:trip_planner/modules/person/person_usecase.dart';

class TripRegisterProvider extends ChangeNotifier {
  final TripUseCase tripUseCase;
  final PersonUseCase personUseCase;

  TripRegisterProvider({ required this.tripUseCase, required this.personUseCase });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorTripTitle;
  String? _errorStartDate;
  String? _errorEndDate;
  String? _errorDate;
  String? _errorName;
  String? _errorAge;
  String? _errorGroup;
  String? _errorStops;

  String? get errorTripTitle => _errorTripTitle;
  String? get errorStartDate => _errorStartDate;
  String? get errorEndDate => _errorEndDate;
  String? get errorDate => _errorDate;
  String? get errorName => _errorName;
  String? get errorAge => _errorAge;
  String? get errorGroup => _errorGroup;
  String? get errorStops => _errorStops;

  bool validateTrip({
    required String tripTitle, 
    required String startDate, 
    required String endDate, 
    required List<Person> group, 
    required List<Stop> stops
  }) {
    _errorTripTitle = tripUseCase.validateTripTitle(tripTitle);
    _errorStartDate = tripUseCase.validateStartDate(startDate);
    _errorEndDate = tripUseCase.validateEndDate(endDate);
    
    if (_errorStartDate == null && _errorEndDate == null) {
      _errorDate = tripUseCase.validateDates(startDate, endDate);
    }
    
    _errorGroup = tripUseCase.validateGroup(group);
    _errorStops = tripUseCase.validateStops(stops);

    notifyListeners();

    return _errorTripTitle == null &&
        _errorStartDate == null &&
        _errorEndDate == null &&
        _errorDate == null &&
        _errorGroup == null &&
        _errorStops == null;
  }

  bool validatePerson(String name, String age) {
    _errorName = personUseCase.validateName(name);
    _errorAge = personUseCase.validateAge(age);
    
    notifyListeners();
    
    return _errorName == null && _errorAge == null;
  }

  Future<String?> createTrip(Trip trip) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await tripUseCase.createTrip(trip);
      return result;
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}