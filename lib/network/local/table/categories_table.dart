import 'package:sqflite/sqflite.dart';

class CategoriesTable {

  static final CategoriesTable _categoriesTable = CategoriesTable._internal();

  factory CategoriesTable() {
    return _categoriesTable;
  }

  CategoriesTable._internal();

  static final String CATEGORY_TABLE_NAME = "categories";
  static final String COLUMN_TYPE = "type";
  static final String COLUMN_PARENT = "parent";
  static final String COLUMN_CATEGORY_COLOR = "category_color";
  static final String COLUMN_ID = "id";
  static final String COLUMN_CATEGORY_ID = "category_id";
  static final String COLUMN_NAME = "name";
  static final String COLUMN_LABEL = "label";
  static final String COLUMN_DESCRIPTION = "description";
  static final String COLUMN_ICON_ID = "icon_id";
  static final String COLUMN_LINKS = "links";
  static final String COLUMN_SUBSCRIPTION = "subscription";
  static final String COLUMN_DISPLAY = "display";

  static Future categoryCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        CATEGORY_TABLE_NAME +
        " (" +
        COLUMN_TYPE +
        " TEXT,  " +
        COLUMN_PARENT +
        " TEXT,  " +
        COLUMN_CATEGORY_COLOR +
        " TEXT,  " +
        COLUMN_ID +
        " TEXT PRIMARY KEY,  " +
        COLUMN_CATEGORY_ID +
        " TEXT,  " +
        COLUMN_NAME +
        " TEXT,  " +
        COLUMN_LINKS +
        " TEXT, " +
        COLUMN_LABEL +
        " TEXT,  " +
        COLUMN_DESCRIPTION +
        " TEXT,  " +
        COLUMN_ICON_ID +
        " TEXT,  " +
        COLUMN_SUBSCRIPTION +
        " INTEGER " +
        COLUMN_DISPLAY +
        " INTEGER " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> categoryTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $CATEGORY_TABLE_NAME'));
    return count;
  }

  static Future<int> insertCategoryTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(CATEGORY_TABLE_NAME, row);
  }
}
