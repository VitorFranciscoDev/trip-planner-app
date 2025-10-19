import 'package:flutter/foundation.dart';
import 'package:trip_planner/modules/user/user_usecase.dart';

class ConfigProvider with ChangeNotifier {
  ConfigProvider({required this.userUseCase});

  final UserUseCase userUseCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorName;
  String? _errorEmail;
  String? _errorPassword;

  String? get errorName => _errorName;
  String? get errorEmail => _errorEmail;
  String? get errorPassword => _errorPassword;

  // validate the fields
  bool validateFields(String name, String email, String password) {
    _errorName = userUseCase.validateName(name);
    _errorEmail = userUseCase.validateEmail(email);
    _errorPassword = userUseCase.validatePassword(password);
    
    notifyListeners();
    
    return _errorName == null && _errorEmail == null && _errorPassword == null;
  }

  // register the user
  Future<String?> registerUser(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await userUseCase.registerUser(name, email, password);
      
      if(result != null) {
        _errorEmail = result;
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