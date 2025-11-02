import 'package:sqflite/sqflite.dart';

// Trip's Table [DB]
// [user_id] references the ID of the actual user
class TripsTable {
  static createTable(Database db) async {
    await db.execute('''
      CREATE TABLE trips (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        transport TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        concluded INT NOT NULL,
        FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');
  }
}