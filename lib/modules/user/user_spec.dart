import 'package:trip_planner/entities/user.dart';

// User's Contracts
abstract class IUserRepository {
  Future<int> addUser(User user);
  Future<int> deleteUser(int? id);
  Future<int> updateUser(User user);
  Future<User?> doLogin(String email, String password);
  Future<User?> getUserByEmail(String email);
}