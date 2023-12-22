import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const databaseName = "userInformation.db";
  static const databaseVersion = 1;
  Database? database;

  /// USER TABLE ///
  final tableName = 'users';
  final userId = '_id';
  final userName = 'name';
  final userEmail = 'email';
  final userEnrollNumber = 'enrollNumber';
  final userAddress = 'address';

  /// database helper singleton class ///
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  /// get database ///
  Future<Database> getDatabase() async {
    if (database != null) return database!;
    database = await initDataBase();
    print("DB::::> $database");
    return database!;
  }

  /// init database
  initDataBase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, databaseName);
    print("DATABASE_INIT_PATH:::>>>$path");
    return await openDatabase(path,
        version: databaseVersion, onCreate: onCreate);
  }

  /// create database table user ///
  Future onCreate(Database db, int version) async {
    await db.execute('''
           CREATE TABLE IF NOT EXISTS $tableName (
             $userId INTEGER PRIMARY KEY,
             $userName TEXT NOT NULL,
             $userEmail TEXT NOT NULL,
             $userEnrollNumber TEXT NOT NULL,
             $userAddress TEXT NOT NULL
           )
           ''');
  }

}
