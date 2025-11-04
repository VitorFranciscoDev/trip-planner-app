import 'package:flutter/foundation.dart';
import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';

// Trip's Model
class Trip {
  final int? id; // Trip's ID [Auto Increment]
  final int? user_id; // User's ID [Related to Trip]
  final String title;
  final String transport;
  final String start_date;
  final String end_date;
  final Uint8List? map_image;
  final bool concluded;
  final List<Person>? group;
  final List<Stop>? stops;

  Trip({ this.id, this.user_id, required this.title, required this.transport, required this.start_date, required this.end_date, this.map_image, required this.concluded, this.group, this.stops });

  // Transforms Trip in Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'title': title,
      'transport': transport,
      'start_date': start_date,
      'end_date': end_date,
      'map_image': map_image,
      'concluded': concluded ? 1 : 0, // Transforms in Int
    };
  }

  // Transforms Map<String, dynamic> in Trip
  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'],
      user_id: map['user_id'],
      title: map['title'],
      transport: map['transport'],
      start_date: map['start_date'],
      end_date: map['end_date'],
      map_image: map['map_image'],
      concluded: map['concluded'] == 1, // Transforms in Bool
    );
  }
}