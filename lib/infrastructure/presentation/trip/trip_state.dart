import 'package:flutter/material.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';
import 'package:trip_planner/modules/person/person_usecase.dart';
import 'package:trip_planner/modules/trip/trip_usecase.dart';

class TripProvider extends ChangeNotifier {
  // Use Cases
  final TripUseCase tripUseCase;
  final PersonUseCase personUseCase;

  // Trip data
  Trip? _trip;
  Trip? get trip => _trip;

  set trip(Trip? value) {
    _trip = value;
    notifyListeners();
  }

  // List of Trips
  List<Trip> _trips = [];
  List<Trip> get trips => _trips;

  // Group data
  List<Person> _group = [];
  List<Person> get group => _group;

  // Stops data
  List<Stop> _stops = [];
  List<Stop> get stops => _stops;

  set stops(List<Stop>? value) {
    _stops = value ?? [];
    notifyListeners();
  }

  // Loading boolean
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Errors
  String? _errorTripTitle;
  String? _errorStartDate;
  String? _errorEndDate;
  String? _errorDate;
  String? _errorName;
  String? _errorAge;
  String? _errorGroup;
  String? _errorStops;
  String? _errorStopStartDate;
  String? _errorStopEndDate;

  String? get errorTripTitle => _errorTripTitle;
  String? get errorStartDate => _errorStartDate;
  String? get errorEndDate => _errorEndDate;
  String? get errorDate => _errorDate;
  String? get errorName => _errorName;
  String? get errorAge => _errorAge;
  String? get errorGroup => _errorGroup;
  String? get errorStops => _errorStops;
  String? get errorStopStartDate => _errorStopStartDate;
  String? get errorStopEndDate => _errorStopEndDate;

  // Trip dates for validation
  String? _tripStartDate;
  String? _tripEndDate;

  TripProvider({ required this.tripUseCase, required this.personUseCase });

  Future<void> loadAllTrips(User user) async {
    _isLoading = true;
    notifyListeners();

    try {
      _trips = await tripUseCase.getAllTrips(user.id!);
    } catch (e) {
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

  void removePerson(Person person) {
    _group.remove(person);
    notifyListeners();
  }

  void clearGroup() {
    _group.clear();
    notifyListeners();
  }

  // Stops management methods
  void addStop(Stop stop) {
    _stops.add(stop);
    notifyListeners();
  }

  void removeStop(Stop stop) {
    _stops.remove(stop);
    notifyListeners();
  }

  void clearStops() {
    _stops.clear();
    notifyListeners();
  }

  // Set trip dates for stop validation
  void setTripDates(String startDate, String endDate) {
    _tripStartDate = startDate;
    _tripEndDate = endDate;
  }

  // Validate stop dates
  bool validateStopDates({
    required String startDate,
    required String endDate,
    required BuildContext context,
  }) {
    final l10n = AppLocalizations.of(context);
    _errorStopStartDate = null;
    _errorStopEndDate = null;

    // Check if dates are empty
    if (startDate.isEmpty) {
      _errorStopStartDate = l10n.startDateRequired;
      notifyListeners();
      return false;
    }

    if (endDate.isEmpty) {
      _errorStopEndDate = l10n.endDateRequired;
      notifyListeners();
      return false;
    }

    try {
      final stopStart = DateTime.parse(startDate);
      final stopEnd = DateTime.parse(endDate);

      // Check if stop end date is after start date
      if (stopEnd.isBefore(stopStart)) {
        _errorStopEndDate = "End date must be after start date";
        notifyListeners();
        return false;
      }

      // Validate against trip dates
      if (_tripStartDate != null && _tripEndDate != null) {
        final tripStart = DateTime.parse(_tripStartDate!);
        final tripEnd = DateTime.parse(_tripEndDate!);

        if (stopStart.isBefore(tripStart)) {
          _errorStopStartDate = "Stop cannot start before trip starts";
          notifyListeners();
          return false;
        }

        if (stopEnd.isAfter(tripEnd)) {
          _errorStopEndDate = "Stop cannot end after trip ends";
          notifyListeners();
          return false;
        }
      }

      // Validate against other stops
      if (_stops.isNotEmpty) {
        final lastStop = _stops.last;
        final lastStopEnd = DateTime.parse(lastStop.end_date);

        if (stopStart.isBefore(lastStopEnd)) {
          _errorStopStartDate = "Stop must start after previous stop ends";
          notifyListeners();
          return false;
        }
      }

      notifyListeners();
      return true;
    } catch (e) {
      _errorStopStartDate = "Invalid date format";
      notifyListeners();
      return false;
    }
  }

  // Function to validate the data of the Trip
  bool validateTrip({
    required String tripTitle,
    required List<Person> group,
    required List<Stop> stops,
    required BuildContext context,
  }) {
    _errorTripTitle = tripUseCase.validateTripTitle(tripTitle, context);

    _errorGroup = tripUseCase.validateGroup(group, context);
    _errorStops = tripUseCase.validateStops(stops, context);

    notifyListeners();

    return _errorTripTitle == null &&
        _errorStartDate == null &&
        _errorEndDate == null &&
        _errorDate == null &&
        _errorGroup == null &&
        _errorStops == null;
  }

  bool validatePerson(String name, String age, BuildContext context) {
    _errorName = personUseCase.validateName(name, context);
    _errorAge = personUseCase.validateAge(age, context);

    notifyListeners();

    return _errorName == null && _errorAge == null;
  }

  Future<String?> createTrip(Trip trip, BuildContext context) async {
    final l10n = AppLocalizations.of(context);

    _isLoading = true;
    notifyListeners();

    try {
      final result = await tripUseCase.createTrip(trip, context);

      if (result == null) {
        await loadAllTrips(trip.user_id as User);
        clearGroup();
        clearStops();
      }

      return result;
    } catch (e) {
      return "${l10n.unexpectedError}: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Trip?> getTripById(int id) async {
    try {
      return await tripUseCase.getTripById(id);
    } catch (e) {
      return null;
    }
  }

  Future<String?> deleteTrip(int id, User user, BuildContext context) async {
    try {
      final result = await tripUseCase.deleteTrip(id, context);

      if (result == null) {
        await loadAllTrips(user);
      }

      return result;
    } catch (e) {
      return "Failed to delete trip";
    }
  }

  Future<String?> updateTrip(Trip trip, User user, BuildContext context) async {
    try {
      final result = await tripUseCase.updateTrip(trip, context);

      if (result == null) {
        await loadAllTrips(user);
      }

      return result;
    } catch (e) {
      return "Failed to update trip";
    }
  }
}