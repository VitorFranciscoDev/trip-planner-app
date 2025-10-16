import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_planner/entities/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  UserProvider() {
    loadUser();
  }

  Future<void> registerUser(User user) async {
    _user = user;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(user.toMap()));
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');

    if (userData != null) {
      final map = jsonDecode(userData);
      _user = User.fromMap(map);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _user = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
  }
}