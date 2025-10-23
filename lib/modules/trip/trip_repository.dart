import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/database/database.dart';
import 'package:trip_planner/modules/trip/trip_spec.dart';

class TripRepository implements ITripRepository {
  final database = TripPlannerDatabase();

  @override
  Future<int> registerTrip(Trip trip) async {
    try {
      final db = await database.database;

      return await db.transaction((txn) async {
        final trip_id = await txn.insert('trips', trip.toMap());

        for(var person in trip.group!) {
          await txn.insert('persons', {
            ...person.toMap(),
            'trip_id': trip_id,
          }); 
        }

        for(var stop in trip.stops!) {
          final stop_id = await txn.insert('stops', {
            ...stop.toMap(),
            'trip_id': trip_id,
          }); 
          for(var userExperience in stop.userExperiences!) {
            await txn.insert('user_experiences', {
              ...userExperience.toMap(),
              'stop_id': stop_id,
            });
          }
        }
        
        return trip_id;
      });
    } catch (e) {
      throw Exception("Failed to insert trip: $e");
    }
  }

  @override
  Future<int> deleteTrip(int id) async {
    try {
      final db = await database.database;
      return await db.delete(
        'trips',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception("Failed to delete trip: $e");
    }
  }

  @override
  Future<int> updateTrip(Trip trip) async {
    try {
      final db = await database.database;
      return await db.update(
        'trips',
        trip.toMap(),
        where: 'id = ?',
        whereArgs: [trip.id],
      );
    } catch (e) {
      throw Exception("Failed to update trip: $e");
    }
  }

  @override
  Future<List<Trip>> getAllTrips(int user_id) async {
    try {
      final db = await database.database;
      final result = await db.query('trips', orderBy: 'id DESC');
      return result.map((map) => Trip.fromMap(map)).toList();
    } catch (e) {
      throw Exception("Failed to get trips: $e");
    }
  }

  @override
  Future<Trip?> getTripById(int id) async {
    final db = await database.database;

    final result = await db.query('trips', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) return null;

    final map = result.first;

    final peopleResult = await db.query('persons', where: 'trip_id = ?', whereArgs: [id]);
    final stopsResult = await db.query('stops', where: 'trip_id = ?', whereArgs: [id]);

    return Trip(
      title: map['title'] as String, 
      transport: map['transport'] as String, 
      start_date: map['start_date'] as String, 
      end_date: map['end_date'] as String, 
      concluded: map['concluded'] == 1,
      group: peopleResult.map((p) => Person.fromMap(p)).toList(),
      stops: stopsResult.map((s) => Stop.fromMap(s)).toList(),
    );
  }
}