import 'package:trip_planner/entities/person.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/database/database.dart';
import 'package:trip_planner/modules/trip/trip_spec.dart';

// Implementation of Trip's Contracts [Trip's DB]
class TripRepository implements ITripRepository {
  final database = TripPlannerDatabase();

  // Add Trip in DB
  @override
  Future<int> addTrip(Trip trip) async {
    final db = await database.database;

    try {
      // Transaction to add the whole Trip data in DB
      return await db.transaction((txn) async {
        // Receives the Trip ID
        final trip_id = await txn.insert('trips', trip.toMap());

        // Add the Group in DB
        for(var person in trip.group!) {
          await txn.insert('persons', {
            ...person.toMap(),
            'trip_id': trip_id,
          }); 
        }

        // Add the Stops in DB
        for(var stop in trip.stops!) {
          // Receiver the Stop ID
          final stop_id = await txn.insert('stops', {
            ...stop.toMap(),
            'trip_id': trip_id,
          }); 

          // Add the User Experiences in DB
          for(var userExperience in stop.stopExperiences!) {
            await txn.insert('user_experiences', {
              ...userExperience.toMap(),
              'stop_id': stop_id,
            });
          }
        }
        
        // Returns Trip's ID
        return trip_id;
      });
    } catch (e) {
      throw Exception("Error in Add Trip Repository: $e");
    }
  }

  // Delete Trip in DB
  @override
  Future<int> deleteTrip(int id) async {
    final db = await database.database;

    try {
      // Return the number of rows affected
      return await db.delete(
        'trips',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception("Error in Delete Trip Repository: $e");
    }
  }

  // Update Trip in DB
  @override
  Future<int> updateTrip(Trip trip) async {
    final db = await database.database;

    try {
      // Return the number of rows affected
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

  // Get all the User's Trips
  @override
  Future<List<Trip>?> getAllTrips(int user_id) async {
    final db = await database.database;

    try {
      final result = await db.query(
        'trips', 
        where: 'user_id = ?',
        whereArgs: [user_id], 
        orderBy: 'id DESC',
      );

      List<Trip> trips = [];
      
      for (var map in result) {
        final stopsResult = await db.query(
          'stops',
          where: 'trip_id = ?',
          whereArgs: [map['id']],
        );
        
        final groupResult = await db.query(
          'persons',
          where: 'trip_id = ?',
          whereArgs: [map['id']],
        );
        
        final stops = stopsResult.map((s) => Stop.fromMap(s)).toList();
        final group = groupResult.map((p) => Person.fromMap(p)).toList();
        
        trips.add(Trip(
          id: map['id'] as int?,
          user_id: map['user_id'] as int?,
          title: map['title'] as String,
          transport: map['transport'] as String,
          start_date: map['start_date'] as String,
          end_date: map['end_date'] as String,
          concluded: map['concluded'] == 1,
          stops: stops,
          group: group,
        ));
      }

      return trips;
    } catch (e) {
      throw Exception("Error in Get All Trips Repository: $e");
    }
  }
}