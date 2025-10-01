import 'package:flutter/widgets.dart';
import 'package:trip_planner/entities/user.dart';

class LoginState with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void registerUser(User user) {
    _user = User(name: user.name, email: user.email, password: user.password);
    notifyListeners();
  }

}