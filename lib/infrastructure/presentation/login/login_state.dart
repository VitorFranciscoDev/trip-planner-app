import 'package:flutter/widgets.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/modules/user/user_usecase.dart';

class LoginProvider with ChangeNotifier {
  LoginProvider({required this.userUseCase});

  final UserUseCase userUseCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorEmail;
  String? _errorPassword;

  String? get errorEmail => _errorEmail;
  String? get errorPassword => _errorPassword;

  bool validateFields(String email, String password, BuildContext context) {
    _errorEmail = userUseCase.validateEmail(email, context);
    _errorPassword = userUseCase.validatePassword(password, context);
    
    notifyListeners();
    
    return _errorEmail == null && _errorPassword == null;
  }

  Future<User?> doLogin(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await userUseCase.doLogin(email, password);
      return user;
    } catch (e) {
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}