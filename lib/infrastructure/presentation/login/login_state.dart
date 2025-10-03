import 'package:flutter/widgets.dart';
import 'package:trip_planner/entities/user.dart';

class UserProvider with ChangeNotifier {
  User? user;

  void registerUser(User newUser) {
    user = User(name: newUser.name, email: newUser.email, password: newUser.password);
    notifyListeners();
  }
}