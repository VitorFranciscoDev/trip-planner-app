import 'package:sqflite/sqflite.dart';

class UserTable {
  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT UNIQUE,
        password TEXT
      )
    ''');
  }
}