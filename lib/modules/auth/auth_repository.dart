import 'package:trip_planner/entities/entity_user.dart';
import 'package:trip_planner/infrastructure/database/database.dart';
import 'package:trip_planner/modules/auth/auth_spec.dart';

AuthRepository newAuthRepository(NewTripPlannerDatabase database) {
  return _AuthRepository(database);
}

class _AuthRepository implements AuthRepository {
  const _AuthRepository(this._database);

  final NewTripPlannerDatabase _database;

  @override
  Future<void> attemptLogin(UserCredentials credentials) async {
    final conn = await _database.connection;

    try {
      final user = await conn.query(
        'users',
        where: 'email = ?',
        whereArgs: [credentials.email],
      );
      if (user.isEmpty) {
        return;
      }
    } catch (e) {
      print('failed to login: $e');
    }
  }

  @override
  Future<void> attemptRegister(UserCredentials credentials) async {
    final conn = await _database.connection;

    try {
      await conn.insert('users', credentials.toJSON());
    } catch (e) {
      print('failed to create new account: $e');
    }
  }
}
