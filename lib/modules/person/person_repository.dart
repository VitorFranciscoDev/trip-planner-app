import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/infrastructure/database/database.dart';
import 'package:trip_planner/modules/person/person_spec.dart';

class PersonRepository implements IPersonRepository {
  final database = TripPlannerDatabase();

  @override
  Future<int> updatePerson(Person person) async {
    final db = await database.database;

    try {
      return await db.update(
        'persons',
        person.toMap(),
        where: 'id = ?',
        whereArgs: [person.id],
      );
    } catch(e) {
      throw Exception("Error in Update Person Repository: $e");
    }
  }
}