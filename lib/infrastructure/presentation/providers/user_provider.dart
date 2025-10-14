import 'package:flutter/material.dart';
import 'package:trip_planner/entities/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  void registerUser(User user) {
    _user = user;
    notifyListeners();
  }
}