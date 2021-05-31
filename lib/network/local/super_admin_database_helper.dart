import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/utils/app_strings.dart';

class SuperAdminDatabaseHelper {
  static final SuperAdminDatabaseHelper _superAdminDatabaseHelper =
      SuperAdminDatabaseHelper._internal();

  factory SuperAdminDatabaseHelper() {
    return _superAdminDatabaseHelper;
  }

  SuperAdminDatabaseHelper._internal();

  static Database _db;

  static Future initDataBase() async {
    try {
      var databasesPath = await getDatabasesPath();
      var dbPath = path.join(databasesPath, "admin.db");
      // Check if the database exists
      var exists = await databaseExists(dbPath);

      if (!exists) {
        // Should happen only the first time you launch your application
        print("Creating new copy from asset");
        // Make sure the parent directory exists
        await Directory(path.dirname(dbPath)).create(recursive: true);
        // Copy from asset
        ByteData data =
            await rootBundle.load(path.join("assets", "database/admin.db"));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        // Write and flush the bytes written
        await File(dbPath).writeAsBytes(bytes, flush: true);
        // open the database
        _db = await openDatabase(dbPath, readOnly: true);
      } else {
        debugPrint("database_testing:- Opening existing database");
        _db = await openDatabase(dbPath, readOnly: true);
      }
    } catch (e) {
      debugPrint('database_testing:-  $e');
    }
  }

  static Future<List<MallProfileModel>> getAllVenueProfile() async {
    if (_db == null) {
      await initDataBase();
    }
    List<Map> data;
    await _db.transaction((txn) async {
      data = await txn.query(
        AppString.VENUE_PROFILE_TABLE_NAME,
        columns: [
          "name",
          "label",
          "identifier",
          "key",
          "geofence",
          "db_name",
          "logo_base64",
          "ibeacon_uuid",
          "venue_data",
          "active",
        ],
      );
    });
    debugPrint('database_testing:-   ${data.length}');
    List<MallProfileModel> _mallList = [];
    data.forEach((element) {
      _mallList.add(MallProfileModel.fromJson(element));
    });

    data.map((e) => debugPrint('database_testing:-    $e'));
    return _mallList;
  }

  static Future<List<MallProfileModel>> getDefaultVenueProfile(
      String tableKey) async {
    if (_db == null) {
      await initDataBase();
    }
    List<Map> data;
    await _db.transaction((txn) async {
      data = await txn.query(
        AppString.VENUE_PROFILE_TABLE_NAME,
        columns: [
          "name",
          "label",
          "identifier",
          "key",
          "geofence",
          "db_name",
          "logo_base64",
          "ibeacon_uuid",
          "venue_data",
          "active",
        ],
        where: "key = ?",
        whereArgs: ['$tableKey'],
        limit: 1,
      );
    });
    debugPrint('database_testing:-   ${data.length}');
    List<MallProfileModel> _mallList = [];
    data.forEach((element) {
      _mallList.add(MallProfileModel.fromJson(element));
    });

    data.map((e) => debugPrint('database_testing:-    $e'));
    return _mallList;
  }
}
