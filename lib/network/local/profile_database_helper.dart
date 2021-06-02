import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:wayawaya/common/model/categories_model.dart';
import 'package:wayawaya/utils/app_strings.dart';

class ProfileDatabaseHelper {
  static final ProfileDatabaseHelper _profileDatabaseHelper =
      ProfileDatabaseHelper._internal();

  factory ProfileDatabaseHelper() {
    return _profileDatabaseHelper;
  }

  ProfileDatabaseHelper._internal();

  static Database _db;

  static Future initDataBase(String databasePath) async {
    try {
      var databasesPath = await getDatabasesPath();
      var dbPath = path.join(databasesPath, "$databasePath.db");
      // Check if the database exists
      var exists = await databaseExists(dbPath);

      if (!exists) {
        // Should happen only the first time you launch your application
        print("Creating new copy from asset");
        // Make sure the parent directory exists
        await Directory(path.dirname(dbPath)).create(recursive: true);
        // Copy from asset
        ByteData data = await rootBundle
            .load(path.join("assets", "database/$databasePath.db"));
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

  static Future<List<Category>> getAllCategories(
      String databasePath) async {
    debugPrint('database_testing:-  database path $databasePath');
    if (_db == null) {
      await initDataBase(databasePath);
    }
    List<Map> data;
    await _db.transaction((txn) async {
      data = await txn.query(
        AppString.CATEGORIES_TABLE_NAME,
        columns: [
          "type",
          "parent",
          "category_color",
          "name",
          "id",
          "links",
          "label",
          "description",
          "icon_id",
          "subscription",
          "display",
          "category_id",
        ],
      );
    });
    // _db.close();
    debugPrint('database_testing:-   ${data.length}');
    debugPrint('database_testing:-   $data');
    List<Category> _mallList = [];
    data.forEach((element) {
      _mallList.add(Category.fromJson(element));
    });

    data.map((e) => debugPrint('database_testing:-    $e'));
    return _mallList;
  }
}
