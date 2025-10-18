import 'package:latlong2/latlong.dart';

class SearchResult {
  final String displayName;
  final LatLng position;

  SearchResult({ required this.displayName, required this.position });

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