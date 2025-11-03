import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/modules/user/user_usecase.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider({ required this.userUseCase }) { loadUser(); }

  final UserUseCase userUseCase;

  User? _user;
  User? get user => _user;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorName;
  String? _errorEmail;
  String? _errorPassword;

  String? get errorName => _errorName;
  String? get errorEmail => _errorEmail;
  String? get errorPassword => _errorPassword;

  bool validateRegisterFields(String name, String email, String password, BuildContext context) {
    _errorName = userUseCase.validateName(name, context);
    _errorEmail = userUseCase.validateEmail(email, context);
    _errorPassword = userUseCase.validatePassword(password, context);
    
    notifyListeners();
    
    return _errorName == null && _errorEmail == null && _errorPassword == null;
  }

  bool validateLoginFields(String email, String password, BuildContext context) {
    _errorEmail = userUseCase.validateEmail(email, context);
    _errorPassword = userUseCase.validatePassword(password, context);
    
    notifyListeners();
    
    return _errorEmail == null && _errorPassword == null;
  }

  void clearErrors() {
    _errorName = null;
    _errorEmail = null;
    _errorPassword = null;

    notifyListeners();
  }

  Future<void> loadUser() async {
    _isInitialized = false;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('user_data');

      if (userData != null) {
        final map = jsonDecode(userData);
        _user = User.fromMap(map);
        notifyListeners();
      }
    } catch(e) {
      throw Exception("Error in Load User Provider: $e");
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<String?> addUser(User user, BuildContext context) async {
    final intl = AppLocalizations.of(context);
    _isLoading = true;
    notifyListeners();

    try {
      // Verifies if User with same Email already exists
      final existingUser = await userUseCase.getUserByEmail(user.email);

      if(existingUser != null) {
        return intl.emailAlreadyRegistered;
      }

      // Receives the ID of new User
      final result = await userUseCase.addUser(user);

      if(result > 0) return null;
      return intl.registerError;
    } catch (e) {
      return intl.unexpectedError;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> deleteUser(BuildContext context) async {
    final intl = AppLocalizations.of(context);
    _isLoading = true;
    notifyListeners();

    try {
      // Receives the number of rows affected
      final result = await userUseCase.deleteUser(user?.id);

      if(result > 0) return null;
      return intl.deleteUserError;
    } catch (e) {
      return intl.unexpectedError;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> updateUser(User? user, BuildContext context) async {
    final intl = AppLocalizations.of(context);
    _isLoading = true;
    notifyListeners();

    try {
      // Receives the number of rows affected
      final result = await userUseCase.updateUser(user!);
      
      if(result > 0) {
        _user = user;
        notifyListeners();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(user.toMap()));

        return null;
      }

      return intl.updateInfo;
    } catch (e) {
      return intl.unexpectedError;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> doLogin(String email, String password, BuildContext context) async {
    final intl = AppLocalizations.of(context);
    _isLoading = true;
    notifyListeners();

    try {
      // Receives the User
      final user = await userUseCase.doLogin(email, password);

      if(user!=null) {
        _user = user;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(user.toMap()));

        notifyListeners();

        return null;
      }
      
      return intl.emailPasswordIncorrect;
    } catch (e) {
      return intl.unexpectedError;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _user = null;
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_data');
    } catch(e) {
      throw Exception("Error in Log Out Provider: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
