import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:wayawaya/app/preferences/model/preferences_categories.dart';
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

  static Future<List<PreferencesCategory>> getPreferencesCategories(
      String path,
      String limit,
      String offset,
      ) async {
    debugPrint('database_testing:-  preferences  ');
    if (_db == null) {
      await initDataBase(path);
    }
    List<Map> data;
    String subscribed = "WHERE subscription = 1";
    await _db.transaction((txn) async {
      data = await txn.rawQuery(
          "WITH RECURSIVE menu_tree (category_id, name, label, level, parent, subscription) \n" +
              "AS ( \n" +
              "  SELECT\n" +
              "    category_id, \n" +
              "    '' || name, \n" +
              "    '' || label, \n" +
              "    0, \n" +
              "    parent,\n" +
              "\tsubscription\n" +
              "  FROM categories \n" +
              "  WHERE parent = ''\n" +
              "  UNION ALL\n" +
              "  SELECT\n" +
              "    mn.category_id, \n" +
              "    mt.name || ' <> ' || mn.name, \n" +
              "    mt.label || ' <> ' || mn.label, \n" +
              "    mt.level + 0, \n" +
              "    mt.category_id,\n" +
              "\tmn.subscription\n" +
              "  FROM categories mn, menu_tree mt \n" +
              "  WHERE mn.parent = mt.category_id \n" +
              ") \n" +
              "SELECT * FROM menu_tree \n" +
              subscribed +
              " AND level >= 0 \n" +
              "ORDER BY level DESC, name LIMIT " +
              limit +
              " OFFSET " +
              offset);
    });
    // _db.close();
    debugPrint('database_testing:-  preferences  ${data.length}');
    // debugPrint('database_testing:-   $data');
    List<PreferencesCategory> _preferencesCategoriesList = [];
    data.forEach((element) {
      _preferencesCategoriesList.add(PreferencesCategory.fromJson(element));
    });

    return _preferencesCategoriesList;
  }

}
