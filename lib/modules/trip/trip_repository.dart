import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/database/database.dart';
import 'package:trip_planner/modules/trip/trip_spec.dart';

class TripRepository implements ITripRepository {
  final dbHelper = DBHelper();

  @override
  Future<int> registerTrip(Trip trip) async {
    try {
      final db = await dbHelper.database;

      return await db.transaction((txn) async {
        final tripId = await txn.insert('trips', trip.toMap());

        for(var person in trip.group!) {
          await txn.insert('people', {
            ...person.toMap(),
            'tripId': tripId,
          }); 
        }

        for(var stop in trip.stops!) {
          await txn.insert('stops', {
            ...stop.toMap(),
            'tripId': tripId,
          }); 
        }
        
        return tripId;
      });
    } catch (e) {
      throw Exception("Failed to insert trip: $e");
    }
  }

  @override
  Future<List<Trip>> getAllTrips() async {
    try {
      final db = await dbHelper.database;
      final result = await db.query('trips', orderBy: 'id DESC');
      return result.map((map) => Trip.fromMap(map)).toList();
    } catch (e) {
      throw Exception("Failed to get trips: $e");
    }
  }

  @override
  Future<Trip?> getTripById(int id) async {
  final db = await dbHelper.database;

  final result = await db.query('trips', where: 'id = ?', whereArgs: [id]);
  if (result.isEmpty) return null;

  final tripMap = result.first;

  final personsResult = await db.query('persons', where: 'tripId = ?', whereArgs: [id]);
  final stopsResult = await db.query('stops', where: 'tripId = ?', whereArgs: [id]);

  return Trip(
    id: tripMap['id'] as int,
    title: tripMap['title'] as String,
    transport: tripMap['transport'] as String,
    startDate: tripMap['startDate'] as String,
    endDate: tripMap['endDate'] as String,
    group: personsResult.map((p) => Person.fromMap(p)).toList(),
    stops: stopsResult.map((s) => Stop.fromMap(s)).toList(),
  );
}

  @override
  Future<int> updateTrip(Trip trip) async {
    try {
      final db = await dbHelper.database;
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
  Future<int> deleteTrip(int id) async {
    try {
      final db = await dbHelper.database;
      return await db.delete(
        'trips',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception("Failed to delete trip: $e");
    }
  }
}