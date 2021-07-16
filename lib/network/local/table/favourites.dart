import 'package:sqflite/sqflite.dart';

class Favourites {
  static final Favourites _favouritesTable = Favourites._internal();

  factory Favourites() {
    return _favouritesTable;
  }

  Favourites._internal();

  static final String FAVOURITES_TABLE_NAME = "favourites";
  static final String COLUMN_RETAIL_UNIT_ID = "retail_unit_id";
  static final String COLUMN_VENUE_ID = "venue_id";
  static final String COLUMN_USER_ID = "user_id";
  static final String COLUMN_STATUS = "status";

  static Future favouritesCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        FAVOURITES_TABLE_NAME +
        " (" +
        COLUMN_RETAIL_UNIT_ID +
        " TEXT,  " +
        COLUMN_USER_ID +
        " TEXT, " +
        COLUMN_VENUE_ID +
        " TEXT, " +
        COLUMN_STATUS +
        "TEXT " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> favouritesTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $FAVOURITES_TABLE_NAME'));
    return count;
  }

  static Future<int> insertFavouritesTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(FAVOURITES_TABLE_NAME, row);
  }
}
