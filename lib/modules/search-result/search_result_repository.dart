import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip_planner/entities/search_result.dart';
import 'package:trip_planner/modules/search-result/search_result_spec.dart';

// Implementation of Search Results Contracts
class SearchResultRepository implements ISearchResultRepository {
  static const String _baseUrl = 'nominatim.openstreetmap.org';
  
  static const Map<String, String> _headers = {
    'User-Agent': 'TripPlannerApp/1.0 (tripplanner@gmail.com)',
  };

  @override
  Future<List<SearchResult>> searchLocation(String query) async {
    if (query.isEmpty) return [];

    try {
      final url = Uri.https(
        _baseUrl,
        '/search',
        {
          'q': query,
          'format': 'json',
          'limit': '5',
          'addressdetails': '1',
        },
      );

      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Returns locations
        return data.map((e) => SearchResult.fromJson(e)).toList();
      }

      return [];
    } catch (e) {
      throw Exception("Error in Search Location Repository: $e");
    }
  }
}
