import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/infrastructure/database/database.dart';
import 'package:trip_planner/modules/user/user_spec.dart';

// Implementation of the Repository [User's DB]
class UserRepository implements IUserRepository {
  final database = TripPlannerDatabase();

  // Add the User in DB
  @override
  Future<int> addUser(User user) async {
    final db = await database.database;

    try {
      // Return the index of the User
      return await db.insert('users', user.toMap());
    } catch (e) {
      throw Exception("Error in Add User Repository: $e");
    }
  } 

  // Delete the User from DB
  @override
  Future<int> deleteUser(int? id) async {
    final db = await database.database;

    try {
      // Return the number of rows affected
      return await db.delete(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch(e) {
      throw Exception("Error in Delete User Repository: $e");
    }
  }

  // Update the User in DB
  @override
  Future<int> updateUser(User user) async {
    final db = await database.database;

    try {
      // Update the User in DB and returns the number of lines affected
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

  // Login in App
  @override
  Future<User?> doLogin(String email, String password) async {
    final db = await database.database;

    try {
      // Query in DB
      final result = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      // If the user exists, returns
      if(result.isNotEmpty) {
        return User.fromMap(result.first);
      }

      return null;
    } catch(e) {
      throw Exception("Error in Do Login Repository: $e");
    }
  }

  // Get the User by Email [Validation for Register (Can't have two users with the same Email)]
  @override
  Future<User?> getUserByEmail(String email) async {
    final db = await database.database;

    try {
      // Query in the DB
      final existingUser = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );

      // If the user exists, returns
      if(existingUser.isNotEmpty) {
        return User.fromMap(existingUser.first);
      }

      return null;
    } catch(e) {
      throw Exception("Error in Get User By Email Repository: $e");
    }
  }

}