import 'package:flutter/material.dart';

class BottomNavigatorProvider with ChangeNotifier {
  int index = 0;

  void setIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }
}