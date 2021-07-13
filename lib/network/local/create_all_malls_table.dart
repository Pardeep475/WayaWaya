import 'package:sqflite/sqflite.dart';

class CreateAllMallTable {
  static final CreateAllMallTable _createAllMallTable =
      CreateAllMallTable._internal();

  factory CreateAllMallTable() {
    return _createAllMallTable;
  }

  CreateAllMallTable._internal();

  // All Malls
  static final _allMallTableName = 'all_mall_table_name';
  static final allMallName = 'name';
  static final allMallLabel = 'label';
  static final allMallIdentifier = 'identifier';
  static final allMallKey = 'key';
  static final allMallGeofence = 'geo_location';
  static final allMallDbName = 'db_name';
  static final allMallLogoBase64 = 'logo_base64';
  static final allMallIBeaconUid = 'ibeacon_uuid';
  static final allMallVenueData = 'venue_data';
  static final allMallActive = 'active';

  // create table for malls data
  static Future allMallCreateTable({Database db, int version}) async {
    await db.execute('''
    CREATE TABLE $_allMallTableName (
   ID INTEGER PRIMARY KEY AUTOINCREMENT,
   $allMallName  TEXT DEFAULT '',
   $allMallLabel TEXT DEFAULT '',
   $allMallIdentifier TEXT DEFAULT '',
   $allMallKey TEXT DEFAULT '',
   $allMallGeofence  TEXT DEFAULT '',
   $allMallDbName  TEXT DEFAULT '',
   $allMallLogoBase64  TEXT DEFAULT '',
   $allMallIBeaconUid  TEXT DEFAULT '',
   $allMallVenueData  TEXT DEFAULT '',
   $allMallActive  INTEGER DEFAULT 0
   );
    ''');
  }

  static Future<int> getAllMallsLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $_allMallTableName'));
    return count;
  }

  static Future<int> insertAllMalls(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(_allMallTableName, row);
  }
}
