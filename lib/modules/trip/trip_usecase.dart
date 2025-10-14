import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/modules/trip/trip_spec.dart';

class TripUseCase implements ITripUseCase {
  @override
  String? validateTripTitle(String tripTitle) => tripTitle.isEmpty ? "Trip Title cannot be blank" : null;

  @override
  String? validateStartDate(String startDate) => startDate.isEmpty ? "Start Date cannot be blank" : null;

  @override
  String? validateEndDate(String endDate) => endDate.isEmpty ? "End Date cannot be blank" : null;

  DateTime? parseDate(String text) { 
    try { 
      return DateTime.parse(text); 
    } catch(e) { 
      return null; 
    } 
  }

  @override
  String? validateDates(String startDate, String endDate) {
    DateTime? start = parseDate(startDate);
    DateTime? end = parseDate(endDate);

    if (start != null && end != null) {
      if (start.isAfter(end)) {
        return "Start Date cannot be after End Date";
      }
    }

    return null;
  }

  @override
  String? validateGroup(List<Person> group) => group.isEmpty ? "Group cannot be empty" : null;

  @override
  String? validateStops(List<Stop> stops) => stops.isEmpty ? "Stops cannot be empty" : null;

  

}