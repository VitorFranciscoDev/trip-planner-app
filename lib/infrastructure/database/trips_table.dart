import 'package:sqflite/sqflite.dart';

class TripsTable {
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE trips (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        transport TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL
      )
    ''');
  }
}