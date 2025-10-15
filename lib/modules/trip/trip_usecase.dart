import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/modules/trip/trip_spec.dart';

class TripUseCase {
  final ITripRepository tripRepository;

  TripUseCase({ required this.tripRepository });

  String? validateTripTitle(String tripTitle) => tripTitle.isEmpty ? "Trip Title cannot be blank" : null;

  String? validateStartDate(String startDate) => startDate.isEmpty ? "Start Date cannot be blank" : null;

  String? validateEndDate(String endDate) => endDate.isEmpty ? "End Date cannot be blank" : null;

  DateTime? parseDate(String text) { 
    try { 
      return DateTime.parse(text); 
    } catch(e) { 
      return null; 
    } 
  }

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

  String? validateGroup(List<Person> group) => group.isEmpty ? "Group cannot be empty" : null;

  String? validateStops(List<Stop> stops) => stops.isEmpty ? "Stops cannot be empty" : null;

  Future<String?> createTrip(Trip trip) async {
    try {
      final result = await tripRepository.registerTrip(trip);
      
      if (result > 0) {
        return null;
      }
      return "Failed to create trip";
    } catch (e) {
      return "Error creating trip: ${e.toString()}";
    }
  }

  Future<List<Trip>> getAllTrips() async {
    return await tripRepository.getAllTrips();
  }

  Future<Trip?> getTripById(int id) async {
    return await tripRepository.getTripById(id);
  }

  Future<String?> updateTrip(Trip trip) async {
    try {
      final result = await tripRepository.updateTrip(trip);
      
      if (result > 0) {
        return null;
      }
      return "Failed to update trip";
    } catch (e) {
      return "Error updating trip: ${e.toString()}";
    }
  }

  Future<String?> deleteTrip(int id) async {
    try {
      final result = await tripRepository.deleteTrip(id);
      
      if (result > 0) {
        return null;
      }
      return "Failed to delete trip";
    } catch (e) {
      return "Error deleting trip: ${e.toString()}";
    }
  }
}