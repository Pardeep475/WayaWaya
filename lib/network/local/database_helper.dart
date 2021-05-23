import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../utils/app_strings.dart';

class DataBaseHelper {
  static final _dbName = 'wayawayadatabase.db';
  static final int _dbVersion = 1;

// make it singleton class
  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // _database = await initiateDataBase();
    return _database;
  }

  initiateDataBase({String dbName}) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    debugPrint('database_testing:-----  path    $path');
    bool dataExist = await databaseExists(path);
    debugPrint('database_testing:-----  isDatabase exist    $dataExist');
    if (dataExist) {
      bool isDataBaseDelete = await _deleteDatabase(path);
      debugPrint("database_testing :-  is database delete  $isDataBaseDelete");
      if (isDataBaseDelete) {
        // return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
        _database = await openDatabase(path, version: _dbVersion);
      }
    } else {
      _database =  await openDatabase(path, version: _dbVersion);
    }
  }

  Future<bool> databaseExists(String path) async {
    bool isDataBaseExist = await databaseFactory.databaseExists(path);
    return isDataBaseExist;
  }

  Future<bool> _deleteDatabase(String path) async {
    if (_database == null) return false;
    final int version = await _database.getVersion();
    if (version == null) return false;
    debugPrint(
        "database_testing :-  database version  $version    $_dbVersion");
    if (version < _dbVersion) {
      await deleteDatabase(path);
      return true;
    } else {
      return false;
    }
  }

  Future closeDataBase() async {
    if (_database != null) {
      await _database.close();
      return;
    }
    return;
  }

  // admin table
  static const String COLUMN_NAME = "name";
  static const String COLUMN_LABEL = "label";
  static const String COLUMN_KEY = "key";
  static const String COLUMN_IDENTIFIER = "identifier";
  static const String COLUMN_DB_NAME = "db_name";
  static const String COLUMN_GEOFENCE = "geofence";
  static const String COLUMN_LOGO_BASE64 = "logo_base64";
  static const String COLUMN_IBEACON_UUID = "ibeacon_uuid";
  static const String COLUMN_DEFAULT = "active";
  static const String COLUMN_DATA = "venue_data";

  Future _onCreateVenueProfileTable(Database db, int version) async {
    db.execute('''CREATE TABLE " 
      ${AppString.VENUE_PROFILE_TABLE_NAME} ( $COLUMN_IDENTIFIER TEXT PRIMARY KEY,  
      $COLUMN_NAME TEXT NOT NULL, $COLUMN_LABEL TEXT NOT NULL,
      $COLUMN_KEY TEXT NOT NULL, $COLUMN_LOGO_BASE64 TEXT NOT NULL,
      $COLUMN_DB_NAME TEXT, $COLUMN_GEOFENCE TEXT, $COLUMN_DEFAULT INTEGER,
      $COLUMN_IBEACON_UUID TEXT, $COLUMN_DATA TEXT ); 
  ''');
  }

  Future<List<Map<String, dynamic>>> queryVenueProfileItem(String dbName) async {
    // Database _db = await instance.database;
    // // return await _db.query(_tableName, where: '$loadNumber = ?', whereArgs: [loadNumber]);
    // // (await _db.query('sqlite_master', columns: ['type', 'name']))
    // //     .forEach((row) {
    // //   print(row.values);
    // // });
    //
    try{
    //
    //   if(_db == null){
    //     debugPrint('pardeep_testing:-   db is null');
    //     return null;
    //   }

      Directory directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path, dbName);
      Database _db = await openDatabase(path, version: _dbVersion);

      // (await _db.query('sqlite_master', columns: ['type', 'name']))
      //     .forEach((row) {
      //   print(row.values.first.toString());
      // });
      final tables = await _db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');
      // var tableNames = (await _db
      //     .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
      //     .map((row) => row['name'] as String)
      //     .toList(growable: false);
      debugPrint('pardeep_testing:-   $tables');
    }catch(e){
      debugPrint('pardeep_testing:-   error $e');
    }


    // return await _db.rawQuery('SELECT * FROM null');
  }

// static final _tableName = 'loadNumber';
// static final _id = 'ID';
// static final loadNumber = 'LOAD_NUMBER';
// static final invoiceCount = 'INVOICE_COUNT';
// static final invoicePath = 'INVOICE_PATH';
// static final invoicePdfPath = 'INVOICE_PDF_PATH';
// static final bolCount = 'BOL_COUNT';
// static final bolPath = 'BOL_PATH';
// static final bolPdfPath = 'BOL_PDF_PATH';
// static final rateConfirmationCount = 'RATE_CONFIRMATION_COUNT';
// static final rateConfirmationPath = 'RATE_CONFIRMATION_PATH';
// static final rateConfirmationPdfPath = 'RATE_CONFIRMATION_PDF_PATH';
// static final lumperReceiptCount = 'LUMPER_RECEIPT_COUNT';
// static final lumperReceiptPath = 'LUMPER_RECEIPT_PATH';
// static final lumperReceiptPdfPath = 'LUMPER_RECEIPT_PDF_PATH';
// static final otherCount = 'OTHER_COUNT';
// static final otherPath = 'OTHER_PATH';
// static final otherPdfPath = 'OTHER_PDF_PATH';
// static final isEmailSent = 'IS_EMAIL_SENT';
//

//
// Future _onCreate(Database db, int version) async {
//   db.execute('''
//   CREATE TABLE $_tableName(
//  $_id INTEGER PRIMARY KEY AUTOINCREMENT,
//  $loadNumber  INT NOT NULL,
//  $invoiceCount INT DEFAULT 0,
//  $invoicePath TEXT,
//  $invoicePdfPath TEXT,
//  $bolCount INT DEFAULT 0,
//  $bolPath  TEXT,
//  $bolPdfPath  TEXT,
//  $rateConfirmationCount  INT DEFAULT 0,
//  $rateConfirmationPath  TEXT,
//  $rateConfirmationPdfPath TEXT,
//  $lumperReceiptCount  INT DEFAULT 0,
//  $lumperReceiptPath  TEXT,
//  $lumperReceiptPdfPath TEXT,
//  $otherCount  INT DEFAULT 0,
//  $otherPath  TEXT,
//  $otherPdfPath TEXT,
//  $isEmailSent  INT DEFAULT 0
//   )
//   ''');
// }
//
// Future<int> insert(Map<String, dynamic> row) async {
//   Database _db = await instance.database;
//   return await _db.insert(_tableName, row);
// }
//
// Future<List<Map<String, dynamic>>> queryItem(int loadNumber) async {
//   debugPrint('database_testing:-  loadNumber :-   $loadNumber');
//   Database _db = await instance.database;
//   // return await _db.query(_tableName, where: '$loadNumber = ?', whereArgs: [loadNumber]);
//   return await _db.rawQuery('SELECT * FROM $_tableName WHERE LOAD_NUMBER = $loadNumber');
//
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
