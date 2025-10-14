import 'dart:convert';
import 'package:http/http.dart' as http;

class StopUseCase {
  Future<Map<String, dynamic>> reverseGeocode(double lat, double lon) async {
  final String url = 'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load address');
  }
}
}