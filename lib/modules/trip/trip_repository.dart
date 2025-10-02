import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/database/database.dart';

class TripRepository {
  final dbHelper = DBHelper();

  Future<int> insertTrip(Trip trip) async {
    final db = await dbHelper.database;
    return await db.insert('trips', trip.toMap());
  }
}