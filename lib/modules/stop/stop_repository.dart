import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class StopRepository {
  static const String _baseUrl = 'https://nominatim.openstreetmap.org';
  
  static const Map<String, String> _headers = {
    'User-Agent': 'TripPlanner/1.0 (trip_planner_app)',
  };

  Future<String?> getAddressFromCoordinates(LatLng position) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/reverse?lat=${position.latitude}&lon=${position.longitude}&format=json',
      );

      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'];
        return address['city'] ?? address['suburb'] ?? address['country'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}