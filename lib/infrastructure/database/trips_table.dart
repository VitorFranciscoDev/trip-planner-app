import 'package:sqflite/sqflite.dart';

class TripsTable {
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE trips (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        transport TEXT,
        start_date TEXT,
        end_date TEXT,
        participants TEXT
      )
    ''');
  }
}