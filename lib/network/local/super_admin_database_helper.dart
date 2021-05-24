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

  static Future<List<MallProfileModel>> getVenueProfile() async {
    if (_db == null) {
      await initDataBase();
    }
    // dynamic value = await _db.query(AppString.VENUE_PROFILE_TABLE_NAME);
    // debugPrint('database_testing:-    $value');
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
    // return mallProfileModel.map((e) => MallProfileModel.fromJson(e)).toList();
    // return data.map((e) => MallProfileModel.fromJson(e)).toList();
    return _mallList;
  }

//   Future<void> init() async {
//     // io.Directory applicationDirectory =
//     //     await getApplicationDocumentsDirectory();
//     //
//     // String dbPathEnglish =
//     //     path.join(applicationDirectory.path, "database/admin.db");
//     //
//     // bool dbExistsEnglish = await io.File(dbPathEnglish).exists();
//     //
//     // if (!dbExistsEnglish) {
//     //   // Copy from asset
//     //   ByteData data =
//     //       await rootBundle.load(path.join("assets", "database/admin.db"));
//     //   List<int> bytes =
//     //       data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//     //
//     //   // Write and flush the bytes written
//     //   await io.File(dbPathEnglish).writeAsBytes(bytes, flush: true);
//     // }
//
//     // // >> To get paths you need these 2 lines
//     // final manifestContent =
//     //     await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
//     //
//     // final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//     // // >> To get paths you need these 2 lines
//     //
//     // final imagePaths = manifestMap.keys
//     //     .where((String key) => key.contains('database/'))
//     //     .where((String key) => key.contains('admin.db'))
//     //     .toList();
//     //
//     // imagePaths.forEach((element) async {
//     //   debugPrint('pardeep_testing_database :--- Database   Name     $element');
//     //   this._db = await openDatabase(element);
//     //   await getVenueProfile();
//     // });
//
//     var databasesPath = await getDatabasesPath();
//     var dbPath = path.join(databasesPath, "admin.db");
//
// // delete existing if any
//     await deleteDatabase(dbPath);
//
// // Make sure the parent directory exists
//     try {
//       await Directory(path.dirname(dbPath)).create(recursive: true);
//     } catch (_) {}
//
// // Copy from asset
//     ByteData data =
//         await rootBundle.load(path.join("assets", "database/admin.db"));
//     List<int> bytes =
//         data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//     await new File(dbPath).writeAsBytes(bytes, flush: true);
//
// // open the database
//     _db = await openDatabase(dbPath, readOnly: true);
//     getVenueProfile();
//   }

  /// get all the words from english dictionary

// Future getVenueProfile() async {
//   if (_db == null) {
//     debugPrint(
//         'pardeep_testing:-  bd is not initiated, initiate using [init(db)] function');
//     return "bd is not initiated, initiate using [init(db)] function";
//   }
//
//   (await _db.query('sqlite_master', columns: ['type', 'name']))
//       .forEach((row) {
//     print(row.values);
//   });
//
//   dynamic value = await _db.query(AppString.VENUE_PROFILE_TABLE_NAME);
//   debugPrint('pardeep_testing:-  $value');
//
//   // List<Map> words;
//   //
//   // await _db.transaction((txn) async {
//   //   words = await txn.query(
//   //     "words",
//   //     columns: [
//   //       "en_word",
//   //       "en_definition",
//   //     ],
//   //   );
//   // });
//   //
//   // return words.map((e) => EnglishWord.fromJson(e)).toList();
// }
}
