import 'package:sqflite/sqflite.dart';

class RetailUnitTable {
  static final RetailUnitTable _retailUnitTable = RetailUnitTable._internal();

  factory RetailUnitTable() {
    return _retailUnitTable;
  }

  RetailUnitTable._internal();

  static final String RETAIL_UNIT_TABLE_NAME = "retail_units";

  static final String COLUMN_ID = "rid";
  static final String COLUMN_BLOG_LINK = "blog_link";
  static final String COLUMN_COST_CENTRE_CODE = "cost_centre_code";
  static final String COLUMN_SUB_LOCATIONS = "sub_locations";
  static final String COLUMN_ECOMMERCE_DETAILS = "ecommerce_details";
  static final String COLUMN_STATUS = "status";
  static final String COLUMN_NAME = "name";
  static final String COLUMN_DESCRIPTION = "description";
  static final String COLUMN_CATEGORIES = "categories";
  static final String COLUMN_FAVORUITE = "favourite";

  static Future retailUnitCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        RETAIL_UNIT_TABLE_NAME +
        " (" +
        COLUMN_ID +
        " TEXT ,  " +
        COLUMN_BLOG_LINK +
        " TEXT ,  " +
        COLUMN_COST_CENTRE_CODE +
        " TEXT ,  " +
        COLUMN_SUB_LOCATIONS +
        " TEXT ,  " +
        COLUMN_ECOMMERCE_DETAILS +
        " TEXT ,  " +
        COLUMN_STATUS +
        " TEXT ,  " +
        COLUMN_NAME +
        " TEXT ,  " +
        COLUMN_DESCRIPTION +
        " TEXT, " +
        COLUMN_CATEGORIES +
        " TEXT, " +
        COLUMN_FAVORUITE +
        " TEXT " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> retailUnitTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $RETAIL_UNIT_TABLE_NAME'));
    return count;
  }

  static Future<int> insertRetailUnitTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(RETAIL_UNIT_TABLE_NAME, row);
  }
}
