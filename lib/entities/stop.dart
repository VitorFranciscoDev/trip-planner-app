import 'package:trip_planner/entities/user_experience.dart';

class Stop {
  final int? id;
  final int? tripId;
  final String location;
  final String startDate;
  final String endDate;
  final double latitude;
  final double longitude;
  final List<UserExperience>? userExperiences;

  Stop({ this.id, this.tripId, required this.location, required this.startDate, required this.endDate, required this.latitude, required this.longitude, this.userExperiences });

  //Transforms Stop in Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tripId': tripId,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  //Transforms Map in Stop
  factory Stop.fromMap(Map<String, dynamic> map) {
    return Stop(
      id: map['id'],
      tripId: map['tripId'],
      location: map['location'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}