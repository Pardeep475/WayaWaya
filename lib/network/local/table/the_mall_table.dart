import 'package:sqflite/sqflite.dart';

class TheMallTable {
  static final TheMallTable _theMallTableTable = TheMallTable._internal();

  factory TheMallTable() {
    return _theMallTableTable;
  }

  TheMallTable._internal();

  static final String THE_MALL_TABLE_NAME = "the_mall";
  static final String COLUMN_DISPLAY_NAME = "display_name";
  static final String COLUMN_ICON = "icon";
  static final String COLUMN_SEQUENCE_NUMBER = "sequence_number";
  static final String COLUMN_TYPE = "type";

  static Future theMallCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        THE_MALL_TABLE_NAME +
        " ( " +
        COLUMN_DISPLAY_NAME +
        " TEXT, " +
        COLUMN_ICON +
        " TEXT, " +
        COLUMN_SEQUENCE_NUMBER +
        " INTEGER, " +
        COLUMN_TYPE +
        "  TEXT " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> theMallTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $THE_MALL_TABLE_NAME'));
    return count;
  }

  static Future<int> insertTheMallTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(THE_MALL_TABLE_NAME, row);
  }
}
