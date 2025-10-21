import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip_planner/entities/search_result.dart';

class SearchResultRepository {
  static const String _baseUrl = 'https://nominatim.openstreetmap.org';
  
  static const Map<String, String> _headers = {
    'User-Agent': 'TripPlanner/1.0 (trip_planner_app)',
  };

  Future<List<SearchResult>> searchLocation(String query) async {
    if (query.isEmpty) return [];

    try {
      final url = Uri.parse(
        '$_baseUrl/search?q=$query&format=json&limit=5&addressdetails=1',
      );

      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        return data.map((json) => SearchResult.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search location');
      }
    } catch (e) {
      return [];
    }
  }
}