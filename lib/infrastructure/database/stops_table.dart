import 'package:sqflite/sqflite.dart';

class StopsTable {
  static createTable(Database db) async {
    await db.execute('''
      CREATE TABLE stops (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        trip_id INTEGER NOT NULL,
        location TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        FOREIGN KEY(trip_id) REFERENCES trips(id)
      )
    ''');
  }
}