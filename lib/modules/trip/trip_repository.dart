import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/database/database.dart';
import 'package:trip_planner/modules/trip/trip_spec.dart';

class TripRepository implements ITripRepository {
  final dbHelper = DBHelper();

  @override
  Future<int> registerTrip(Trip trip) async {
    try {
      final db = await dbHelper.database;
      return await db.insert('trips', trip.toMap());
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
    try {
      final db = await dbHelper.database;
      final result = await db.query(
        'trips',
        where: 'id = ?',
        whereArgs: [id],
      );
      
      if (result.isNotEmpty) {
        return Trip.fromMap(result.first);
      }
      return null;
    } catch (e) {
      throw Exception("Failed to get trip: $e");
    }
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