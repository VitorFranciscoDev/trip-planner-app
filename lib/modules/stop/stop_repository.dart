import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:trip_planner/modules/stop/stop_spec.dart';

// Stop's Repository
class StopRepository implements IStopRepository {
  static const String _baseUrl = 'https://nominatim.openstreetmap.org';
  
  static const Map<String, String> _headers = {
    'User-Agent': 'TripPlanner/1.0 (trip_planner_app)',
  };

  // Get Address based on Coordinates(lat, lng) from an API[Web Nominatin]
  Future<String?> getAddressFromCoordinates(LatLng position) async {
    try {
      final url = Uri.parse('$_baseUrl/reverse?lat=${position.latitude}&lon=${position.longitude}&format=json');

      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'];
        return address['city'] ?? address['suburb'] ?? address['country'];
      }

      return null;
    } catch (e) {
      throw Exception("Error in Get Address From Coordinates Repository: $e");
    }
  }
}