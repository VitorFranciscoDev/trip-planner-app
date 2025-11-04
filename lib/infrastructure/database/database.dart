import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:trip_planner/infrastructure/database/persons_table.dart';
import 'package:trip_planner/infrastructure/database/stops_table.dart';
import 'package:trip_planner/infrastructure/database/trips_table.dart';
import 'package:trip_planner/infrastructure/database/user_experiences_table.dart';
import 'package:trip_planner/infrastructure/database/users_table.dart';

// Creation of DB and Tables
class TripPlannerDatabase {
  // Instances of the DB
  static final TripPlannerDatabase _instance = TripPlannerDatabase._internal();
  factory TripPlannerDatabase() => _instance;
  TripPlannerDatabase._internal();
  static Database? db;

  // DB getter
  Future<Database> get database async {
    if(db != null) return db!;
    db = await _initDatabase();
    return db!;
  }

  // Init DB
  Future<Database> _initDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'trip_planner.db');

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await UsersTable.createTable(db);
        await TripsTable.createTable(db);
        await PersonsTable.createTable(db);
        await StopsTable.createTable(db);
        await UserExperiencesTable.createTable(db);
      },
    );
  }
}