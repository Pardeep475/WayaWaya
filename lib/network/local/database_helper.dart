import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  // static final _dbName = 'wayawayadatabase.db';
  // static final _dbVersion = 1;
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
  // // make it singleton class
  // DataBaseHelper._privateConstructor();
  //
  // static final DataBaseHelper instance = DataBaseHelper._privateConstructor();
  //
  // static Database _database;
  //
  // Future<Database> get database async {
  //   if (_database != null) return _database;
  //
  //   _database = await _initiateDataBase();
  //   return _database;
  // }
  //
  // _initiateDataBase() async {
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   String path = join(directory.path, _dbName);
  //   return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  // }
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
