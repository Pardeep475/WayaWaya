import 'package:sqflite/sqflite.dart';

class TempLoyaltyUserPointTable {
  static final TempLoyaltyUserPointTable _tempLoyaltyUserPointTable =
      TempLoyaltyUserPointTable._internal();

  factory TempLoyaltyUserPointTable() {
    return _tempLoyaltyUserPointTable;
  }

  TempLoyaltyUserPointTable._internal();

  static final String LOYALTY_USER_POINT_TABLE_NAME = "loyalty_user_point";
  static final String COLUMN_REDEEMED = "redeemed";
  static final String COLUMN_TOTAL_POINTS_EARNED = "total_points_earned";
  static final String COLUMN_AVAILABLE_POINTS = "available_points";

  static Future tempLoyaltyUserPointCreateTable(
      {Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        LOYALTY_USER_POINT_TABLE_NAME +
        " (" +
        COLUMN_REDEEMED +
        " TEXT,  " +
        COLUMN_TOTAL_POINTS_EARNED +
        " INTEGER, " +
        COLUMN_AVAILABLE_POINTS +
        " INTEGER " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> tempLoyaltyUserPointTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(await db
        .rawQuery('SELECT COUNT(*) FROM $LOYALTY_USER_POINT_TABLE_NAME'));
    return count;
  }

  static Future<int> insertTempLoyaltyUserPointTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(LOYALTY_USER_POINT_TABLE_NAME, row);
  }
}
