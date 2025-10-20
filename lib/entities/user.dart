import 'package:trip_planner/entities/trip.dart';

class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final List<Trip>? trips;

  User({ this.id, required this.name, required this.email, required this.password, this.trips });

  // transforms user in map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // transforms map in user
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}