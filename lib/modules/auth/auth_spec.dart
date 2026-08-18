import 'package:trip_planner/entities/entity_user.dart';

/// Represents a interface for managing auth database actions.
abstract class AuthRepository {
  /// A user-attempt to login in the app.
  Future<void> attemptLogin(UserCredentials credentials);

  /// A user-attempt to create a new account in the app.
  Future<void> attemptRegister(UserCredentials credentials);
}

/// Represents a interface for managing auth actions.
abstract class AuthUseCase {
  /// A user-attempt to login in the app.
  Future<void> attemptLogin(UserCredentials credentials);

  /// A user-attempt to create a new account in the app.
  Future<void> attemptRegister(UserCredentials credentials);
}