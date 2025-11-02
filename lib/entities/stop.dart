import 'package:trip_planner/entities/stop_experience.dart';

// Model of Stop
class Stop {
  final int? id;
  final int? trip_id; // Trip's ID
  final String location;
  final String? img;
  final String start_date;
  final String end_date;
  final double latitude;
  final double longitude;
  final List<StopExperience>? stopExperiences; // Stop's experiences

  // Constructor
  Stop({ this.id, this.trip_id, required this.location, this.img, required this.start_date, required this.end_date, required this.latitude, required this.longitude, this.stopExperiences });

  // Transforms Stop in Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'trip_id': trip_id,
      'location': location,
      'start_date': start_date,
      'end_date': end_date,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Transforms Map<String, dynamic> in Stop
  factory Stop.fromMap(Map<String, dynamic> map) {
    return Stop(
      id: map['id'],
      trip_id: map['trip_id'],
      location: map['location'],
      start_date: map['start_date'],
      end_date: map['end_date'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}