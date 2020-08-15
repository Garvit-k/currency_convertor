import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Logger log = new Logger();
  final TAG = "DataBaseHelper";
  String databaseName = "database.db";
  int databaseVersion = 1;
  String databaseTable = "usertable";
  String columnUsername = "username";
  String columnPassword = "password";
  String columnEmail = "email";
  String columnSalt = "salt";

  DatabaseHelper._privateConstructor();

  static Database _database;

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<dynamic> get database async{
    if(_database != null) {
      print("db get return");
      return _database;
    }
    else {
      _database = await initDatabase();
      print("intialized db");
      return _database;
    }
  }

  initDatabase() async{
    log.d(TAG + "initDatabase");
    Directory databaseDir = await getApplicationDocumentsDirectory();
    String path = join(databaseDir.path, databaseName);
    return await openDatabase(path, version: databaseVersion, onCreate: (Database database, int version) async{
      String createTableQuery = "CREATE TABLE $databaseTable ($columnUsername	TEXT NOT NULL UNIQUE,"
          " $columnPassword	TEXT NOT NULL, "
          "$columnEmail	TEXT,"
          " $columnSalt	TEXT NOT NULL,"
          " PRIMARY KEY($columnUsername) );";
      log.d(TAG+"creating table");
      print("creating tables");
      //await database.execute(createTableQuery);
      return await database.execute(createTableQuery);
    });
  }

  Future<int> insertData(Map<String, dynamic> row) async{
//    Database database = await instance.database;
//    log.d(TAG+ "inserting "+row.toString());
//    return await database.insert(databaseTable, row);
  //print(row);
  final db = await database;
  return await db.insert(databaseTable,row);
  }

  Future<List<Map<String, dynamic>>> getData(String username) async{
    Database database = await instance.database;
    return await database.query(databaseTable,
        columns: [columnUsername,columnPassword,columnEmail,columnSalt],
        where: "$columnUsername = ?",
        whereArgs: [username]);

//    return await database.rawQuery("SELECT * FROM $databaseTable WHERE $columnUsername = $username ;");
//    return await database.rawQuery("SELECT * FROM $databaseTable;");
  }

}