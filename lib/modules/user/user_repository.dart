import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/infrastructure/database/database.dart';

class UserRepository {
  final dbHelper = DBHelper();

  // function to get the user by email
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

  // function to insert the User in the Database
  Future<int> insertUser(User user) async {
    final db = await dbHelper.database;
    return await db.insert('users', user.toMap());
  }

  // function to do Login
  Future<User?> doLogin(String email, String password) async {
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
  }
}