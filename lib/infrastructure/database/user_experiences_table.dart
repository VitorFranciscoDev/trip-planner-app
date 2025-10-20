import 'package:sqflite/sqflite.dart';

class UserExperiencesTable {
  static createTable(Database db) async {
    await db.execute('''
      CREATE TABLE user_experiences (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stop_id INTEGER NOT NULL,
        experience TEXT NOT NULL,
        FOREIGN KEY(stop_id) REFERENCES stops(id)
      )
    ''');
  }
}