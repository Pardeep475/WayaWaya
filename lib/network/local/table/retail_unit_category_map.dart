import 'package:sqflite/sqflite.dart';

class RetailUnitCategoryMap {
  static final RetailUnitCategoryMap _retailUnitCategoryMap =
      RetailUnitCategoryMap._internal();

  factory RetailUnitCategoryMap() {
    return _retailUnitCategoryMap;
  }

  RetailUnitCategoryMap._internal();

  static final String RETAIL_CATEGORY_MAP_TABLE_NAME = "retail_category_map";

  static final String COLUMN_RID = "rid";
  static final String COLUMN_CID = "cid";

  static Future retailUnitCategoryMapCreateTable(
      {Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        RETAIL_CATEGORY_MAP_TABLE_NAME +
        " (" +
        COLUMN_RID +
        " TEXT, " +
        COLUMN_CID +
        " TEXT" +
        " ); ";

    await db.execute(createTable);
  }

  static Future<int> getRetailUnitCategoryMapLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(await db
        .rawQuery('SELECT COUNT(*) FROM $RETAIL_CATEGORY_MAP_TABLE_NAME'));
    return count;
  }

  static Future<int> insertRetailUnitCategoryMap(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(RETAIL_CATEGORY_MAP_TABLE_NAME, row);
  }
}
