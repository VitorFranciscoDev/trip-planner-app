import 'package:trip_planner/entities/entity_user.dart';

/// Interface to manage user actions.
abstract class AppUserRepository {
  /// Returns the current application user information.
  Future<AppUser?> getUserInformation();
}

/// Interface to manage user actions.
abstract class AppUserUseCase {
  /// Returns the current application user information.
  Future<AppUser?> getUserInformation();
}