import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/modules/user/user_usecase.dart';

class AuthProvider with ChangeNotifier {

  final UserUseCase userUseCase; // User's Use Cases

  // Actual User
  User? _user;
  User? get user => _user;

  // Loading boolean
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // Errors
  String? _errorName;
  String? _errorEmail;
  String? _errorPassword;

  // Errors Getters
  String? get errorName => _errorName;
  String? get errorEmail => _errorEmail;
  String? get errorPassword => _errorPassword;

  // Constructor [Load the User(if it already has one)]
  AuthProvider({required this.userUseCase}) {
    loadUser();
  }

  // Function to get the User's Data from SharedPreferences
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');

    if (userData != null) {
      final map = jsonDecode(userData);
      _user = User.fromMap(map);
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Validate the Register fields
  bool validateRegisterFields(String name, String email, String password, BuildContext context) {
    _errorName = userUseCase.validateName(name, context);
    _errorEmail = userUseCase.validateEmail(email, context);
    _errorPassword = userUseCase.validatePassword(password, context);
    
    notifyListeners();
    
    return _errorName == null && _errorEmail == null && _errorPassword == null;
  }

  // Validate the Login fields
  bool validateLoginFields(String email, String password, BuildContext context) {
    _errorEmail = userUseCase.validateEmail(email, context);
    _errorPassword = userUseCase.validatePassword(password, context);
    
    notifyListeners();
    
    return _errorEmail == null && _errorPassword == null;
  }

  // Function to Register the User in the DB and SharedPreferences
  Future<String?> registerUser(String name, String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      return await userUseCase.registerUser(name, email, password, context);
    } catch (e) {
      return "Unexpected error. Try Again";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Function to do Login in the App [if User exists, he's saved on SharedPreferences]
  Future<String?> doLogin(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await userUseCase.doLogin(email, password);

      if(user!=null) {
        _user = user;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(user.toMap()));

        notifyListeners();
      }
      
      return null;
    } catch (e) {
      return "Unexpected Error. Try Again";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> updateUser(User? user) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedUser = await userUseCase.updateUser(user!);
      
      if(updatedUser != null) {
        _user = user;
        notifyListeners();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(user.toMap()));
      }

      return null;
    } catch (e) {
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> deleteUser(int? id, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      return await userUseCase.deleteUser(id, context);
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Function to Log Out of the App [Removes the User from SharedPreferences]
  Future<void> logout() async {
    _user = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
  }
}
