import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/database/database.dart';
import 'package:trip_planner/modules/trip/trip_spec.dart';

// Implementation of Trip's Contracts [Trip's DB]
class TripRepository implements ITripRepository {
  final database = TripPlannerDatabase();

  @override
  Future<int> addTrip(Trip trip) async {
    final db = await database.database;

    try {
      return await db.transaction((txn) async {
        // Receives the Trip ID
        final trip_id = await txn.insert('trips', trip.toMap());

        for(var person in trip.group!) {
          await txn.insert('persons', {
            ...person.toMap(),
            'trip_id': trip_id,
          }); 
        }

        for(var stop in trip.stops!) {
          // Receives the Stop ID
          final stop_id = await txn.insert('stops', {
            ...stop.toMap(),
            'trip_id': trip_id,
          }); 

          for(var userExperience in stop.stopExperiences!) {
            await txn.insert('user_experiences', {
              ...userExperience.toMap(),
              'stop_id': stop_id,
            });
          }
        }
        
        // Return Trip ID
        return trip_id;
      });
    } catch (e) {
      throw Exception("Error in Add Trip Repository: $e");
    }
  }

  @override
  Future<int> deleteTrip(int id) async {
    final db = await database.database;

    try {
      // Returns the number of rows affected
      return await db.delete(
        'trips',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception("Error in Delete Trip Repository: $e");
    }
  }

  @override
  Future<int> updateTrip(Trip trip) async {
    final db = await database.database;

    try {
      // Returns the number of rows affected
      return await db.update(
        'trips',
        trip.toMap(),
        where: 'id = ?',
        whereArgs: [trip.id],
      );
    } catch (e) {
      throw Exception("Error in Update Trip Repository: $e");
    }
  }

  @override
  Future<List<Trip>?> getAllTrips(int user_id) async {
    final db = await database.database;

    try {
      // Receives the Trips
      final result = await db.query(
        'trips', 
        where: 'user_id = ?',
        whereArgs: [user_id],
      );

      List<Trip> trips = [];
      
      for (var map in result) {
        final groupResult = await db.query(
          'persons',
          where: 'trip_id = ?',
          whereArgs: [map['id']],
        );

        final stopsResult = await db.query(
          'stops',
          where: 'trip_id = ?',
          whereArgs: [map['id']],
        );
        
        final group = groupResult.map((p) => Person.fromMap(p)).toList();
        final stops = stopsResult.map((s) => Stop.fromMap(s)).toList();
        
        trips.add(
            Trip(
            id: map['id'] as int?,
            user_id: map['user_id'] as int?,
            title: map['title'] as String,
            transport: map['transport'] as String,
            start_date: map['start_date'] as String,
            end_date: map['end_date'] as String,
            concluded: map['concluded'] == 1,
            group: group,
            stops: stops,
          )
        );
      }

      return trips;
    } catch (e) {
      throw Exception("Error in Get All Trips Repository: $e");
    }
  }
}