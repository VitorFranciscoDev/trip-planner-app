import 'package:flutter/widgets.dart';
import 'package:trip_planner/entities/person.dart';

class GroupProvider with ChangeNotifier {
  final List<Person> _group = [];

  List<Person> get group => _group;

  void addPerson(Person person) {
    _group.add(person);
    notifyListeners();
  }

  void removePerson(Person person) {
    _group.remove(person);
    notifyListeners();
  }
}