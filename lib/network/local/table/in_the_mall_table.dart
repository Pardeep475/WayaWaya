import 'package:sqflite/sqflite.dart';

class InTheMallTable {
  static final InTheMallTable _inTheMallTable = InTheMallTable._internal();

  factory InTheMallTable() {
    return _inTheMallTable;
  }

  InTheMallTable._internal();

  static final String IN_THE_MALL_TABLE_NAME = "whats_happening";

  static final String COLUMN_NAME = "name";
  static final String COLUMN_DESCRIPTION = "description";
  static final String COLUMN_IMAGE_URL = "image_url";
  static final String COLUMN_START_DATE = "start_date";
  static final String COLUMN_CATEGORY = "category";
  static final String COLUMN_END_DATE = "end_date";
  static final String COLUMN_SHARED = "shared";
  static final String COLUMN_LIKES = "likes";

  static Future inTheMallCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        IN_THE_MALL_TABLE_NAME +
        " (" +
        COLUMN_NAME +
        " TEXT PRIMARY KEY, " +
        COLUMN_DESCRIPTION +
        " TEXT NOT NULL, " +
        COLUMN_IMAGE_URL +
        " TEXT NOT NULL, " +
        COLUMN_START_DATE +
        " INTEGER NOT NULL, " +
        COLUMN_END_DATE +
        " INTEGER NOT NULL, " +
        COLUMN_CATEGORY +
        " INTEGER NOT NULL, " +
        COLUMN_SHARED +
        " TEXT, " +
        COLUMN_LIKES +
        " TEXT" +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> inTheMallTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $IN_THE_MALL_TABLE_NAME'));
    return count;
  }

  static Future<int> insertInTheMallTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(IN_THE_MALL_TABLE_NAME, row);
  }
}
