import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/modules/user/user_usecase.dart';

class ConfigProvider with ChangeNotifier {
  ConfigProvider({required this.userUseCase});

  final UserUseCase userUseCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorName;
  String? _errorEmail;
  String? _errorPassword;
  String? _error;

  String? get errorName => _errorName;
  String? get errorEmail => _errorEmail;
  String? get errorPassword => _errorPassword;
  String? get error => _error;

  // validate the fields
  bool validateFields(String name, String email, String password, BuildContext context) {
    _errorName = userUseCase.validateName(name, context);
    _errorEmail = userUseCase.validateEmail(email, context);
    _errorPassword = userUseCase.validatePassword(password, context);
    
    notifyListeners();
    
    return _errorName == null && _errorEmail == null && _errorPassword == null;
  }

  Future<User?> updateUser(User? user) async {
    _isLoading = true;
    notifyListeners();

    try {
      return await userUseCase.updateUser(user!);
      
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
      final result = await userUseCase.deleteUser(id, context);
      
      if(result != null) {
        _error = result;
        notifyListeners();
      }
      
      return result;
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
}