import 'package:sqflite/sqflite.dart';

class LoyaltyTable {
  static final LoyaltyTable _loyaltyTable = LoyaltyTable._internal();

  factory LoyaltyTable() {
    return _loyaltyTable;
  }

  LoyaltyTable._internal();


   static final String LOYALTY_TABLE_NAME = "loyalty";
   static final String COLUMN_ID = "_id";
   static final String COLUMN_USER_ID = "user_id";
   static final String COLUMN_CAMPAIGN_ID = "campaign_id";
   static final String COLUMN_TIMESTAMP = "timestamp";
   static final String COLUMN_TYPE = "type";
   static final String COLUMN_AMOUNT = "amount";
   static final String COLUMN_POINTS = "points";
   static final String COLUMN_STATUS = "status";
   static final String COLUMN_DESCRIPTION = "description";
   static final String COLUMN_ACTIVATION_STATUS = "activation_status";
   static final String COLUMN_OPENING_BALANCE = "opening_balance";
   static final String COLUMN_SHOP_ID = "shopid";
   static final String COLUMN_CODE = "code";
   static final String COLUMN_BEACON = "beacon";
  
  static Future loyaltyCreateTable({Database db, int version}) async {
     final String createTable =
        "CREATE TABLE " + LOYALTY_TABLE_NAME + " (" +
            COLUMN_ID + " TEXT, " +
            COLUMN_USER_ID + " TEXT,  " +
            COLUMN_CAMPAIGN_ID + " TEXT,  " +
            COLUMN_TIMESTAMP + " TEXT,  " +
            COLUMN_TYPE + " TEXT,  " +
            COLUMN_AMOUNT + " INTEGER,  " +
            COLUMN_POINTS + " INTEGER,  " +
            COLUMN_STATUS + " TEXT,  " +
            COLUMN_DESCRIPTION + " TEXT,  " +
            COLUMN_ACTIVATION_STATUS + " TEXT,  " +
            COLUMN_OPENING_BALANCE + " INTEGER, " +
            COLUMN_SHOP_ID + " TEXT, " +
            COLUMN_CODE + " TEXT, " +
            COLUMN_BEACON + " TEXT " +
            " ); ";
    await db.execute(createTable);
  }

  static Future<int> loyaltyTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $LOYALTY_TABLE_NAME'));
    return count;
  }

  static Future<int> insertLoyaltyTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(LOYALTY_TABLE_NAME, row);
  }
}
