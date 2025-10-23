import 'package:trip_planner/entities/trip.dart';

// Model of User
class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final List<Trip>? trips; // The User's Trips

  // Constructor
  User({ this.id, required this.name, required this.email, required this.password, this.trips });

  // Transforms User in Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Transforms Map<String, dynamic> in User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}