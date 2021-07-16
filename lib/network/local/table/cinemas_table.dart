import 'package:sqflite/sqflite.dart';

class CinemasTable {
  static final CinemasTable _cinemasTable = CinemasTable._internal();

  factory CinemasTable() {
    return _cinemasTable;
  }

  CinemasTable._internal();

  static final String CINEMAS_TABLE_NAME = "cinemas";
  static final String COLUMN_ID = "cinema_id";
  static final String COLUMN_NAME = "name";
  static final String COLUMN_LOGO_PORTRAIT = "logo_portrait";
  static final String COLUMN_LOGO_LANDSCAPE = "logo_landscape";
  static final String COLUMN_DESCRIPTION = "description";
  static final String COLUMN_FILM_RATING = "film_rating";
  static final String COLUMN_CUSTOMER_RATING = "customer_rating";
  static final String COLUMN_SHOWS = "shows";
  static final String COLUMN_TRAILER = "trailer";
  static final String COLUMN_RELEASE_DATE = "release_date";
  static final String COLUMN_RUN_TIME = "run_time";
  static final String COLUMN_GENRE = "genre";

  static Future cinemasCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        CINEMAS_TABLE_NAME +
        " ( " +
        COLUMN_ID +
        " TEXT PRIMARY KEY, " +
        COLUMN_NAME +
        " TEXT, " +
        COLUMN_LOGO_PORTRAIT +
        " TEXT, " +
        COLUMN_LOGO_LANDSCAPE +
        " TEXT, " +
        COLUMN_DESCRIPTION +
        " TEXT, " +
        COLUMN_FILM_RATING +
        " TEXT, " +
        COLUMN_CUSTOMER_RATING +
        "  REAL, " +
        COLUMN_SHOWS +
        " TEXT, " +
        COLUMN_TRAILER +
        " TEXT, " +
        COLUMN_RELEASE_DATE +
        " TEXT, " +
        COLUMN_RUN_TIME +
        " INTEGER, " +
        COLUMN_GENRE +
        " TEXT " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> cinemasTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $CINEMAS_TABLE_NAME'));
    return count;
  }

  static Future<int> insertCinemasTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(CINEMAS_TABLE_NAME, row);
  }
}
