import 'package:sqflite/sqflite.dart';

class TempLoyaltyTable {
  static final TempLoyaltyTable _tempLoyaltyTable =
      TempLoyaltyTable._internal();

  factory TempLoyaltyTable() {
    return _tempLoyaltyTable;
  }

  TempLoyaltyTable._internal();

  static final String TEMP_LOYALTY_TABLE_NAME = "loyalty";
  static final String COLUMN_TIMESTAMP = "timestamp";
  static final String COLUMN_TOTAL_MONTH_POINT = "total_month_point";

  static Future tempLoyaltyCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        TEMP_LOYALTY_TABLE_NAME +
        " (" +
        COLUMN_TIMESTAMP +
        " TEXT,  " +
        COLUMN_TOTAL_MONTH_POINT +
        " INTEGER, " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> tempLoyaltyTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $TEMP_LOYALTY_TABLE_NAME'));
    return count;
  }

  static Future<int> insertTempLoyaltyTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(TEMP_LOYALTY_TABLE_NAME, row);
  }
}
