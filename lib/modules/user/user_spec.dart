import 'package:trip_planner/entities/user.dart';

abstract class IUserRepository {
  Future<int?> registerUser(User user);

  Future<User?> doLogin(String email, String password);

  Future<User?> getUserByEmail(String email);
}