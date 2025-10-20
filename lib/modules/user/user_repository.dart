import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/infrastructure/database/database.dart';
import 'package:trip_planner/modules/user/user_spec.dart';

class UserRepository implements IUserRepository {
  final dbHelper = DBHelper();

  @override
  Future<int> registerUser(User user) async {
    try {
      final db = await dbHelper.database;
      return await db.insert('users', user.toMap());
    } catch (e) {
      throw Exception("Error in Register: $e");
    }
  }

  @override
  Future<User?> doLogin(String email, String password) async {
    try {
      final db = await dbHelper.database;

      final result = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      if(result.isNotEmpty) {
        return User.fromMap(result.first);
      }

      return null;
    } catch(e) {
      throw Exception("Error in Login: $e");
    }
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    final db = await dbHelper.database;

    final existingUser = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if(existingUser.isNotEmpty) {
      return User.fromMap(existingUser.first);
    }

    return null;
  }

  @override
  Future<int> deleteUser(int? id) async {
    final db = await dbHelper.database;

    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<User?> updateUser(User user) async {
    final db = await dbHelper.database;

    try {
      final result = await db.update(
        'users',
        user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
      );

      if (result > 0) return user;
      return null;
    } catch (e) {
      throw Exception("Error updating user: $e");
    }
  }
}