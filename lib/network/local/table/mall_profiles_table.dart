import 'package:sqflite/sqflite.dart';

class MallProfilesTable {
  static final MallProfilesTable _mallProfilesTable =
      MallProfilesTable._internal();

  factory MallProfilesTable() {
    return _mallProfilesTable;
  }

  MallProfilesTable._internal();

  static final String TABLE_NAME_MALL_PROFILE = "mall_profiles";
  static final String COLUMN_MALLNAME = "mallname";
  static final String COLUMN_MALLOCATION = "malllocation";
  static final String COLUMN_MALLUUID = "malluuid";

  // create table for malls data
  static Future mallProfileCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        TABLE_NAME_MALL_PROFILE +
        " (" +
        COLUMN_MALLNAME +
        " , " +
        COLUMN_MALLOCATION +
        " , " +
        COLUMN_MALLUUID +
        " ); ";

    await db.execute(createTable);
  }

  static Future<int> getMallProfileLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $TABLE_NAME_MALL_PROFILE'));
    return count;
  }

  static Future<int> insertAllMalls(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(TABLE_NAME_MALL_PROFILE, row);
  }
}
