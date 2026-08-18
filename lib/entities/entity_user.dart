import 'package:flutter/cupertino.dart';

/// Represents the credentials of an user.
@immutable
final class UserCredentials {
  /// Default constructor.
  const UserCredentials({required this.email, required this.password});

  /// Represents the user's email.
  final String email;

  /// Represents the user's password.
  final String password;

  /// Returns an JSON based on the given [UserCredentials].
  Map<String, dynamic> toJSON() {
    return {'email': email, 'password': password};
  }
}

/// Represents the application user.
@immutable
final class AppUser {
  const AppUser();

  factory AppUser.fromJSON(Map<String, dynamic> json) {
    return AppUser();
  }
}
