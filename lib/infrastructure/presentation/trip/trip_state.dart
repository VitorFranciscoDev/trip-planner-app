import 'package:flutter/widgets.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/modules/trip/trip_usecase.dart';

class TripProvider with ChangeNotifier {
  TripProvider({ required this.tripUseCase });
  
  final TripUseCase tripUseCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Trip> _trips = [];
  List<Trip> get trips => _trips;

  String? _errorTripTitle;
  String? _errorStartDate;
  String? _errorEndDate;
  String? _errorDate;
  String? _errorGroup;
  String? _errorStops;

  String? get errorTripTitle => _errorTripTitle;
  String? get errorStartDate => _errorStartDate;
  String? get errorEndDate => _errorEndDate;
  String? get errorDate => _errorDate;
  String? get errorGroup => _errorGroup;
  String? get errorStops => _errorStops;

  bool validateTrip({
    required String tripTitle,
    required String startDate,
    required String endDate,
    required List<Person> group,
    required List<Stop> stops,
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

  Future<String?> createTrip(Trip trip) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await tripUseCase.createTrip(trip);
      
      if (result == null) {
        await loadAllTrips();
      }
      
      return result;
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAllTrips() async {
    _isLoading = true;
    notifyListeners();

    try {
      _trips = await tripUseCase.getAllTrips();
    } catch (e) {
      _trips = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> deleteTrip(int id) async {
    try {
      final result = await tripUseCase.deleteTrip(id);
      
      if (result == null) {
        await loadAllTrips();
      }
      
      return result;
    } catch (e) {
      return "Failed to delete trip";
    }
  }

  void clearErrors() {
    _errorTripTitle = null;
    _errorStartDate = null;
    _errorEndDate = null;
    _errorDate = null;
    _errorGroup = null;
    _errorStops = null;
    notifyListeners();
  }

}