import 'package:flutter/widgets.dart';
import 'package:trip_planner/entities/stop.dart';

class StopsProvider with ChangeNotifier {
  List<Stop> _stops = [];
  
  List<Stop> get stops => _stops;

  void addStop(Stop stop) {
    _stops.add(stop);
    notifyListeners();
  }

  void removeStop(Stop stop) {
    _stops.remove(stop);
    notifyListeners();
  }
}