import 'package:sqflite/sqflite.dart';

class ThemesTable {
  static final String THEME_TABLE_NAME = "theme";
  static final String ICONS = "icons";
  static final String COLORS = "colors";
  static final String MALL_IMAGES = "images";
  static final String IMAGES = "imagesLogo";

  static Future themesCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        THEME_TABLE_NAME +
        " (" +
        ICONS +
        " TEXT,  " +
        COLORS +
        " TEXT,  " +
        MALL_IMAGES +
        " TEXT,  " +
        IMAGES +
        " TEXT PRIMARY KEY  " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> themesTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $THEME_TABLE_NAME'));
    return count;
  }

  static Future<int> insertThemesTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(THEME_TABLE_NAME, row);
  }
}
