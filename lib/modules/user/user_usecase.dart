import 'package:flutter/material.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/modules/user/user_spec.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';

class UserUseCase {
  UserUseCase({ required this.userRepository });

  final IUserRepository userRepository;

  String? validateName(String name, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return name.isEmpty ? l10n.fieldRequired : null;
  }

  String? validateEmail(String email, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    if(email.isEmpty) {
      return l10n.fieldRequired;
    } else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return l10n.invalidEmail;
    }

    return null;
  }

  String? validatePassword(String password, BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    if(password.isEmpty) {
      return l10n.fieldRequired;
    } else if(password.length < 8) {
      return l10n.passwordTooShort;
    }

    return null;
  }

  Future<String?> registerUser(String name, String email, String password, BuildContext context) async {
    try {
      final existingUser = await userRepository.getUserByEmail(email);

      if(existingUser != null) {
        return "User already exists";
      }

      User user = User(name: name, email: email, password: password);
      
      await userRepository.registerUser(user);
      return null;
    } catch (e) {
      throw Exception("Error in the register: $e");
    }
  }

  Future<User?> doLogin(String email, String password) async {
    return await userRepository.doLogin(email, password);
  }

  Future<User?> updateUser(User user) async {
    return await userRepository.updateUser(user);
  }

  Future<String?> deleteUser(int? id, BuildContext context) async {
    try {
      final result = await userRepository.deleteUser(id);
      
      if(result>0) return null;
      return "Error in deleting user";
    } catch(e) {
      throw Exception("Error in deleting user");
    }
  }

}