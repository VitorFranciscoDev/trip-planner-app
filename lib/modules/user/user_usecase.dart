import 'package:flutter/material.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/modules/user/user_spec.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';

// User's Use Cases
class UserUseCase {
  UserUseCase({ required this.userRepository });

  final IUserRepository userRepository;

  String? validateName(String name, BuildContext context) {
    final intl = AppLocalizations.of(context);

    return name.isEmpty ? intl.nameRequired : null;
  }

  String? validateEmail(String email, BuildContext context) {
    final intl = AppLocalizations.of(context);
    
    if(email.isEmpty) {
      return intl.emailRequired;
    } else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return intl.invalidEmail;
    }

    return null;
  }

  String? validatePassword(String password, BuildContext context) {
    final intl = AppLocalizations.of(context);
    
    if(password.isEmpty) {
      return intl.passwordRequired;
    } else if(password.length < 8) {
      return intl.passwordTooShort;
    }

    return null;
  }

  Future<int> addUser(User user) async {
    try {
      // Returns the index of new User
      return await userRepository.addUser(user);
    } catch (e) {
      throw Exception("Error in Add User Use Case: $e");
    }
  }

  Future<int> deleteUser(int? id) async {
    try {
      // Returns the number of rows affected
      return await userRepository.deleteUser(id);
    } catch(e) {
      throw Exception("Error in Delete User Use Case: $e");
    }
  }

  Future<int> updateUser(User user) async {
    try {
      // Returns the number of rows affected
      return await userRepository.updateUser(user);
    } catch(e) {
      throw Exception("Error in Update User Use Case: $e");
    }
  }

  Future<User?> doLogin(String email, String password) async {
    try {
      // Returns User
      return await userRepository.doLogin(email, password);
    } catch(e) {
      throw Exception("Error in Do Login Use Case: $e");
    }
  }

  Future<User?> getUserByEmail(String email) async {
    try {
      // Returns User
      return await userRepository.getUserByEmail(email);
    } catch(e) {
      throw Exception("Error in Get User By Email Use Case: $e");
    } 
  }

}