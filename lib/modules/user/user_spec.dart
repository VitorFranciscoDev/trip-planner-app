import 'package:trip_planner/entities/user.dart';

abstract class IUserUseCase {
  String? validateName(String name);

  String? validateEmail(String email);

  String? validatePassword(String password);

  Future<User?> validateUser(String email);

  Future<String?> registerUser(String name, String email, String password);

  Future<User?> loginUser(String email, String password);
}