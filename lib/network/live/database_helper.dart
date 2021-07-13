import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wayawaya/network/local/create_all_malls_table.dart';
import 'package:wayawaya/network/local/create_retail_unit_table.dart';

class DataBaseHelperCommon {
  static final _dbName = 'wayawayadatabase.db';
  static final _dbVersion = 1;
  static final _id = 'ID';

  // make it singleton class
  DataBaseHelperCommon._privateConstructor();

  static final DataBaseHelperCommon instance =
      DataBaseHelperCommon._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      _database.close();
      _database = null;
    }

    _database = await _initiateDataBase();
    return _database;
  }

  static _initiateDataBase() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path, _dbName);
      return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
    } catch (e) {
      debugPrint('database exception:-    $e');
    }
  }

  static Future _onCreate(Database db, int version) async {
    await CreateAllMallTable.allMallCreateTable(db: db, version: version);
  }

  // all malls data
  static Future<int> getAllMallsLength() async {
    Database _db = await instance.database;
    int count = await CreateAllMallTable.getAllMallsLength(db: _db);
    return count;
  }

  static Future<int> insertAllMalls(Map<String, dynamic> row) async {
    Database _db = await instance.database;
    return await CreateAllMallTable.insertAllMalls(
        db: _db, row: row);
  }



  // Retail Unit data
  static Future<int> getRetailUnitLength() async {
    Database _db = await instance.database;
    int count = await CreateRetailUnitTable.getRetailUnitLength(db: _db);
    return count;
  }

  static Future<int> insertRetailUnit(Map<String, dynamic> row) async {
    Database _db = await instance.database;
    return await CreateRetailUnitTable.insertRetailUnit(
        db: _db, row: row);
  }

// Future<int> insert(Map<String, dynamic> row) async {
//   Database _db = await instance.database;
//   return await _db.insert(_tableName, row);
// }
//
// Future<List<Map<String, dynamic>>> queryItem(int loadNumber) async {
//   debugPrint('database_testing:-  loadNumber :-   $loadNumber');
//   Database _db = await instance.database;
//   // return await _db.query(_tableName, where: '$loadNumber = ?', whereArgs: [loadNumber]);
//   return await _db
//       .rawQuery('SELECT * FROM $_tableName WHERE LOAD_NUMBER = $loadNumber');
// }
//
// Future<int> update(Map<String, dynamic> row) async {
//   Database _db = await instance.database;
//   int loadNumberValue = row[loadNumber];
//   return await _db.update(_tableName, row,
//       where: '$loadNumber = ?', whereArgs: [loadNumberValue]);
// }
//
// Future<int> delete(int loadNumber) async {
//   Database _db = await instance.database;
//   return await _db
//       .delete(_tableName, where: '$loadNumber = ?', whereArgs: [loadNumber]);
// }
}
