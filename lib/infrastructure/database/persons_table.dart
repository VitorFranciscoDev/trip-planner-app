import 'package:sqflite/sqflite.dart';

// Person's Table [DB]
// [trip_id] references the trip's ID
class PersonsTable {
  static createTable(Database db) async {
    await db.execute('''
      CREATE TABLE persons (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        trip_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        FOREIGN KEY(trip_id) REFERENCES trips(id)
      )
    ''');
  }
}