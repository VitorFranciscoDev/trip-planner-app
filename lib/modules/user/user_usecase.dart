import 'package:flutter/material.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/modules/user/user_spec.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';

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

  // Get User By Email
  Future<User?> getUserByEmail(String email) async {
    try {
      // Returns User from Repository if it exists
      return await userRepository.getUserByEmail(email);
    } catch(e) {
      throw Exception("Error in Get User By Email Use Case: $e");
    } 
  }

  // Register the User
  Future<int> registerUser(User user) async {
    try {
      return await userRepository.registerUser(user);
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
  Future<int> updateUser(User user) async {
    try {
      return await userRepository.updateUser(user);
    } catch(e) {
      throw Exception("Error in Update User Use Case: $e");
    }
  }

  // Delete the User
  Future<int> deleteUser(int? id) async {
    try {
      return await userRepository.deleteUser(id);
    } catch(e) {
      throw Exception("Error in Delete User Use Case: $e");
    }
  }

}