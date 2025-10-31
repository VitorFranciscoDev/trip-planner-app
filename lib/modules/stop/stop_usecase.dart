import 'package:latlong2/latlong.dart';
import 'package:trip_planner/modules/stop/stop_spec.dart';

// Stop's Use Cases
class StopUseCase {
  StopUseCase({ required this.stopRepository });

  final IStopRepository stopRepository;

  // Validation of Start Date
  String? validateStartDate(String startDate) {
    return startDate.isEmpty ? "Start Date cannot be blank" : null;
  }

  // Validation of End Date
  String? validateEndDate(String endDate) {
    return endDate.isEmpty ? "End Date cannot be blank" : null;
  }

  // Date(String) => Date(DateTime)
  DateTime? parseDate(String text) { 
    try { 
      return DateTime.parse(text); 
    } catch(e) { 
      return null; 
    } 
  }

  // Validate both dates
  String? validateDates(String startDate, String endDate) {
    DateTime? start = parseDate(startDate);
    DateTime? end = parseDate(endDate);

    if (start != null && end != null) {
      if (start.isAfter(end)) {
        return "Start cannot be after End";
      }
    }

    return null;
  }

  // Get Address based on Coordinates(lat, lng) from Repository
  Future<String?> getAddressFromCoordinates(LatLng position) async {
    try {
      return await stopRepository.getAddressFromCoordinates(position);
    } catch (e) {
      throw Exception("Error in Get Address From Coordinates Use Case: $e");
    }
  }

  Future<List<LatLng>> getRoute(List<LatLng> points) async {
    try {
      return await stopRepository.getRoute(points);
    } catch(e) {
      throw Exception("Error in Get Route Use Case: $e");
    }
  } 
}