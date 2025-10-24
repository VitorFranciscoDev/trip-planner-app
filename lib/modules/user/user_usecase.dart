import 'package:flutter/material.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/modules/user/user_spec.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';

// User's Use Cases
class UserUseCase {
  UserUseCase({ required this.userRepository }); // Constructor

  final IUserRepository userRepository; // User's Contracts

  // Validate the User's name
  String? validateName(String name, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return name.isEmpty ? l10n.fieldRequired : null;
  }

  // Validate the User's Email
  String? validateEmail(String email, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    if(email.isEmpty) {
      return l10n.fieldRequired;
    } else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return l10n.invalidEmail;
    }

    return null;
  }

  // Validate the User's Password
  String? validatePassword(String password, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    if(password.isEmpty) {
      return l10n.fieldRequired;
    } else if(password.length < 8) {
      return l10n.passwordTooShort;
    }

    return null;
  }

  // Register the User
  Future<String?> registerUser(User user, BuildContext context) async {
    try {
      // Verifies if the email isn't in DB
      final existingUser = await userRepository.getUserByEmail(user.email);

      if(existingUser != null) {
        return "User already exists";
      }
      
      // Repository register the User in DB
      await userRepository.registerUser(user);
      return null;
    } catch (e) {
      throw Exception("Error in Register Use Case: $e");
    }
  }

  // Login in App
  Future<User?> doLogin(String email, String password) async {
    try {
      // Returns the User from Repository if it exists
      return await userRepository.doLogin(email, password);
    } catch(e) {
      throw Exception("Error in Login Use Case: $e");
    }
  }

  // Update the User
  Future<User?> updateUser(User user) async {
    try {
      // Returns the User from Repository
      return await userRepository.updateUser(user);
    } catch(e) {
      throw Exception("Error in Update User Use Case: $e");
    }
  }

  // Delete the User
  Future<String?> deleteUser(int? id, BuildContext context) async {
    try {
      // Receive the number of rows affected
      final result = await userRepository.deleteUser(id);
      
      // if it has any rows affected, returns null
      if(result>0) return null;
      
      return "Error in deleting user";
    } catch(e) {
      throw Exception("Error in Delete User Use Case: $e");
    }
  }

}