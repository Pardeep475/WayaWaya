import 'package:sqflite/sqflite.dart';

class CreateMainMenuPermissionTable {
  static final CreateMainMenuPermissionTable _createMainMenuPermissionTable =
      CreateMainMenuPermissionTable._internal();

  factory CreateMainMenuPermissionTable() {
    return _createMainMenuPermissionTable;
  }

  CreateMainMenuPermissionTable._internal();

  // main menu permission
  static final _mainMenuPermissionTableName = 'main_menu_permission_table_name';
  static final mainMenuPermissionIconName = 'main_menu_permission_icon_name';
  static final mainMenuPermissionTitle = 'main_menu_permission_icon_name';
  static final mainMenuPermissionBackgroundColor =
      'main_menu_permission_back_color';
  static final mainMenuPermissionIconCode = 'main_menu_permission_icon_code';

  // create table for menu permission
  Future mainMenuPermissionCreateTable(Database db, int version) async {
    db.execute('''
    CREATE TABLE $_mainMenuPermissionTableName(
   ID INTEGER PRIMARY KEY AUTOINCREMENT,
   $mainMenuPermissionIconName  TEXT DEFAULT \'\',
   $mainMenuPermissionTitle TEXT DEFAULT \'\',
   $mainMenuPermissionBackgroundColor TEXT DEFAULT \'\',
   $mainMenuPermissionIconCode TEXT DEFAULT \'\',)
    ''');
  }
}
