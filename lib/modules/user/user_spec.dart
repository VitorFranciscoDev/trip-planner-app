import 'package:trip_planner/entities/user.dart';

// User's Contracts
abstract class IUserRepository {
  Future<User?> getUserByEmail(String email);
  Future<int> registerUser(User user);
  Future<User?> doLogin(String email, String password);
  Future<int> updateUser(User user);
  Future<int> deleteUser(int? id);
}