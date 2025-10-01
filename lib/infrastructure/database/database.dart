import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:trip_planner/infrastructure/database/stops_table.dart';
import 'package:trip_planner/infrastructure/database/trips_table.dart';
import 'package:trip_planner/infrastructure/database/user_table.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? db;

  Future<Database> get database async {
    if(db != null) return db!;
    db = await _initDatabase();
    return db!;
  }

  Future<Database> _initDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'trip_planner.db');

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await UserTable.createTable(db);
        await TripsTable.createTable(db);
        await StopsTable.createTable(db);
      },
    );
  }
}