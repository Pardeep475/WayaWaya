import 'package:sqflite/sqflite.dart';

class CreatePreferenceCategoryTable {
  static final CreatePreferenceCategoryTable _createPreferenceCategoryTable =
      CreatePreferenceCategoryTable._internal();

  factory CreatePreferenceCategoryTable() {
    return _createPreferenceCategoryTable;
  }

  CreatePreferenceCategoryTable._internal();

  // preference category
  static final _preferenceCategoryTableName = 'preference_category_table_name';
  static final preferenceCategoryParent = 'parent';
  static final preferenceCategoryCategoryId = 'categoryId';
  static final preferenceCategoryName = 'name';
  static final preferenceCategoryLabel = 'label';
  static final preferenceCategorySubscription = 'subscription';

  // create table for preference category
  Future preferenceCategoryCreateTable(Database db, int version) async {
    db.execute('''
    CREATE TABLE $_preferenceCategoryTableName(
   ID INTEGER PRIMARY KEY AUTOINCREMENT,
   $preferenceCategoryParent  TEXT DEFAULT \'\',
   $preferenceCategoryCategoryId TEXT DEFAULT \'\',
   $preferenceCategoryName TEXT DEFAULT \'\',
   $preferenceCategoryLabel TEXT DEFAULT \'\',
   $preferenceCategorySubscription INT DEFAULT 0,
   )
    ''');
  }
}
