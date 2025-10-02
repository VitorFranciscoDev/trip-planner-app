import 'package:sqflite/sqflite.dart';

class PeopleTable {
  static createTable(Database db) async {
    await db.execute('''
      CREATE TABLE people (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        trip_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        FOREIGN KEY(trip_id) REFERENCES trips(id)
      )
    ''');
  }
}