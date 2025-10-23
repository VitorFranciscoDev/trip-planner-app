import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';
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
    required List<Stop> stops,
    required BuildContext context,
  }) {
    _errorTripTitle = tripUseCase.validateTripTitle(tripTitle, context);
    _errorStartDate = tripUseCase.validateStartDate(startDate, context);
    _errorEndDate = tripUseCase.validateEndDate(endDate, context);
    
    if (_errorStartDate == null && _errorEndDate == null) {
      _errorDate = tripUseCase.validateDates(startDate, endDate, context);
    }
    
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
        await context.read<TripProvider>().loadAllTrips(context);
      }
      
      return result;
    } catch (e) {
      return "${l10n.unexpectedError}: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}