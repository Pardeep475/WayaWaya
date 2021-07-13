import 'package:sqflite/sqflite.dart';

class CreateRetailUnitTable {
  static final CreateRetailUnitTable _createRetailUnitTable =
      CreateRetailUnitTable._internal();

  factory CreateRetailUnitTable() {
    return _createRetailUnitTable;
  }

  CreateRetailUnitTable._internal();

  static final _retailUnitTableName = 'retail_unit_table_name';
  static final retailUnitId = 'retail_unit_id';
  static final retailUnitName = 'retail_unit_name';
  static final retailUnitDescription = 'retail_unit_description';
  static final retailUnitCategoryName = 'retail_unit_category_name';
  static final retailUnitCategories = 'retail_unit_categories';
  static final retailUnitColor = 'retail_unit_color';
  static final retailUnitFavourite = 'retail_unit_favourite';
  static final retailUnitSubLocation = 'retail_unit_sub_location';

  static Future retailUnitCreateTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_retailUnitTableName (
   ID INTEGER PRIMARY KEY AUTOINCREMENT,
   $retailUnitId  TEXT NOT NULL,
   $retailUnitName TEXT NOT NULL,
   $retailUnitDescription TEXT NOT NULL,
   $retailUnitCategoryName TEXT NOT NULL,
   $retailUnitCategories  TEXT NOT NULL,
   $retailUnitColor  TEXT NOT NULL,
   $retailUnitFavourite  TEXT NOT NULL,
   $retailUnitSubLocation  TEXT NOT NULL
   );
    ''');
  }

  static Future<int> getRetailUnitLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $_retailUnitTableName'));
    return count;
  }

  static Future<int> insertRetailUnit(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(_retailUnitTableName, row);
  }
}
