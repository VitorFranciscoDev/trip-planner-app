import 'package:sqflite/sqflite.dart';

// Users Table [DB]
class UsersTable {
  static createTable(Database db) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }
}