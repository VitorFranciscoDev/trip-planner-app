import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';

class Trip {
  final int? id;
  final int? userId;
  final String title;
  final String transport;
  final String start_date;
  final String end_date;
  final bool concluded;
  final List<Person>? group;
  final List<Stop>? stops;

  Trip({ this.id, this.userId, required this.title, required this.transport, required this.start_date, required this.end_date, required this.concluded, this.group, this.stops });

  //Transforms Trip in Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'transport': transport,
      'start_date': start_date,
      'end_date': end_date,
      'concluded': concluded,
    };
  }

  //Transforms Map in Trip
  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'],
      title: map['title'],
      transport: map['transport'],
      start_date: map['start_date'],
      end_date: map['end_date'],
      concluded: map['concluded'],
    );
  }
}