// packages
import 'dart:io';
import 'package:path/path.dart';
// should install these
// refer description for more
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabasehelperDb {
  static final _databasename = "todo.db";
  static final _databaseversion = 1;

  //table name
  static final table = "todo_table";

  //column name
  static final columnID = 'id';
  static final columnHead = 'head';
  static final columnCat = 'Cate';
  static final columnNote = "note";
// a db
  static Database _dataBase;

  //private constructor
  DatabasehelperDb._privateConstructor();
  static final DatabasehelperDb instance =
      DatabasehelperDb._privateConstructor();

  //creating a db
  Future<Database> get database async {
    if (_dataBase != null) return _dataBase;

    //create a db if not exits
    _dataBase = await _initDatabase();
    return _dataBase;
  }

  //funtion to retrun db

  _initDatabase() async {
    Directory docdir = await getApplicationDocumentsDirectory();

    String path = join(docdir.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  //Create a Db becasue it doesnt exist
  Future _onCreate(Database db, int version) async {
    // sql code
    await db.execute('''
      CREATE TABLE $table (
        $columnID INTEGER PRIMARY KEY,
        $columnHead TEXT NOT NULL,
        $columnCat TEXT NOT NULL,
        $columnNote TEXT NOT NULL
      )
      ''');
  }

  //function to insert data
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // function to delete some data
  Future<int> deletedata(int id) async {
    Database db = await instance.database;
    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }

  // function to update some data
  Future<int> update(int id) async {
    Database db = await instance.database;
    var res = await db.update(table, {"name": "Desi Programmer", "age": 2},
        where: "id = ?", whereArgs: [id]);
    return res;
  }
}
