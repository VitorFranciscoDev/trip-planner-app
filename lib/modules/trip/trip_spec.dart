import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';

abstract class ITripUseCase {
  String? validateTripTitle(String tripTitle);

  String? validateStartDate(String startDate);

  String? validateEndDate(String endDate);

  String? validateDates(String startDate, String endDate);

  String? validateGroup(List<Person> group);

  String? validateStops(List<Stop> stops);

  
}