import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/infrastructure/database/database.dart';
import 'package:trip_planner/modules/user/user_spec.dart';

// Implementation of the Repository [User's DB]
class UserRepository implements IUserRepository {
  final database = TripPlannerDatabase();

  @override
  Future<int> addUser(User user) async {
    final db = await database.database;

    try {
      // Returns the index of the User
      return await db.insert('users', user.toMap());
    } catch (e) {
      throw Exception("Error in Add User Repository: $e");
    }
  } 

  @override
  Future<int> deleteUser(int? id) async {
    final db = await database.database;

    try {
      // Returns the number of rows affected
      return await db.delete(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch(e) {
      throw Exception("Error in Delete User Repository: $e");
    }
  }

  @override
  Future<int> updateUser(User user) async {
    final db = await database.database;

    try {
      // Returns the number of rows affected
      return await db.update(
        'users',
        user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
      );
    } catch (e) {
      throw Exception("Error in Update User Repository: $e");
    }
  }

  @override
  Future<User?> doLogin(String email, String password) async {
    final db = await database.database;

    try {
      // Receives User
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
      throw Exception("Error in Do Login Repository: $e");
    }
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    final db = await database.database;

    try {
      // Receives User
      final existingUser = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );

      if(existingUser.isNotEmpty) {
        return User.fromMap(existingUser.first);
      }

      return null;
    } catch(e) {
      throw Exception("Error in Get User By Email Repository: $e");
    }
  }

}