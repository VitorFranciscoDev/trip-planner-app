import 'package:sqflite/sqflite.dart';

class StopsTable {
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE stops (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        trip_id INTEGER,
        location TEXT,
        FOREIGN KEY(trip_id) REFERENCES trips(id)
      )
    ''');
  }
}