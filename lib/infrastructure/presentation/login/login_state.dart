import 'package:flutter/widgets.dart';
import 'package:trip_planner/entities/user.dart';

class UserProvider with ChangeNotifier {
  User? user;

  void registerUser(User user) {
    user = User(name: user.name, email: user.email, password: user.password);
    notifyListeners();
  }
}