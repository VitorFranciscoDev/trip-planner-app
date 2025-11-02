import 'package:latlong2/latlong.dart';

// Model of Search Result
class SearchResult {
  final String displayName;
  final LatLng position;

  SearchResult({ required this.displayName, required this.position });

  // Transforms Json in Search Result
  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      displayName: json['display_name'],
      position: LatLng(
        double.parse(json['lat']), 
        double.parse(json['lon']),
      ),
    );
  }
}