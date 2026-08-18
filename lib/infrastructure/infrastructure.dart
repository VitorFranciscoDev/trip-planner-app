import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trip_planner/infrastructure/database/database.dart';
import 'package:trip_planner/modules/app_user/app_user_repository.dart';
import 'package:trip_planner/modules/app_user/app_user_spec.dart';
import 'package:trip_planner/modules/app_user/app_user_use_case.dart';
import 'package:trip_planner/modules/auth/auth_repository.dart';
import 'package:trip_planner/modules/auth/auth_spec.dart';
import 'package:trip_planner/modules/auth/auth_use_case.dart';

/// Global instance for authentication use case.
late final AuthUseCase authUseCase;

/// Global instance for app user use case.
late final AppUserUseCase appUserUseCase;

/// Initializes the application use cases.
void initialize() {
  // Database
  final database = NewTripPlannerDatabase();

  // Storage
  final storage = FlutterSecureStorage();

  // Repositories
  final authRepository = newAuthRepository(database);
  final appUserRepository = newAppUserRepository(storage);

  // Use cases
  authUseCase = newAuthUseCase(authRepository);
  appUserUseCase = newAppUserUseCase(appUserRepository);
}
