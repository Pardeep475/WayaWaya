import 'package:sqflite/sqflite.dart';

class OfferTable {
  static final OfferTable _offerTable = OfferTable._internal();

  factory OfferTable() {
    return _offerTable;
  }

  OfferTable._internal();

  static final String OFFER_TABLE_NAME = "offer";

  static final String COLUMN_NAME = "name";
  static final String COLUMN_DESCRIPTION = "description";
  static final String COLUMN_URL = "url";
  static final String COLUMN_START_DATE = "start_date";
  static final String COLUMN_END_DATE = "end_date";
  static final String COLUMN_COUPON = "coupon";
  static final String COLUMN_LIKES = "likes";
  static final String COLUMN_CATEGORY = "category";
  static final String COLUMN_DISCOUNT = "discount";

  static Future offerTableCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        OFFER_TABLE_NAME +
        " (" +
        COLUMN_NAME +
        " TEXT PRIMARY KEY, " +
        COLUMN_DESCRIPTION +
        " TEXT NOT NULL, " +
        COLUMN_URL +
        " TEXT NOT NULL, " +
        COLUMN_START_DATE +
        " INTEGER NOT NULL, " +
        COLUMN_END_DATE +
        " INTEGER NOT NULL, " +
        COLUMN_COUPON +
        " TEXT, " +
        COLUMN_LIKES +
        " TEXT, " +
        COLUMN_CATEGORY +
        " TEXT, " +
        COLUMN_DISCOUNT +
        " TEXT" +
        " ); ";

    await db.execute(createTable);
  }

  static Future<int> getOfferTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $OFFER_TABLE_NAME'));
    return count;
  }

  static Future<int> insertOfferTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(OFFER_TABLE_NAME, row);
  }
}
