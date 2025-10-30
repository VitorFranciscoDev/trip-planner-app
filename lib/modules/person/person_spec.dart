import 'package:trip_planner/entities/person.dart';

abstract class IPersonRepository {
  Future<int> updatePerson(Person person);
}