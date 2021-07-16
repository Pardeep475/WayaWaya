import 'package:sqflite/sqflite.dart';

class ServicesTable {
  static final ServicesTable _servicesTable = ServicesTable._internal();

  factory ServicesTable() {
    return _servicesTable;
  }

  ServicesTable._internal();

  static final String SERVICES_TABLE_NAME = "services";
  static final String COLUMN_DISPLAY_NAME = "display_name";
  static final String COLUMN_SERVICE_TYPE = "service_type";
  static final String COLUMN_ICON = "icon";
  static final String COLUMN_COLORS = "color";
  static final String COLUMN_IMAGE = "image";
  static final String COLUMN_SEQUENCE_NUMBER = "sequence_number";
  static final String COLUMN_TYPE = "type";

  static Future servicesCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        SERVICES_TABLE_NAME +
        " ( " +
        COLUMN_DISPLAY_NAME +
        " TEXT, " +
        COLUMN_SERVICE_TYPE +
        " TEXT, " +
        COLUMN_ICON +
        " TEXT, " +
        COLUMN_COLORS +
        " TEXT, " +
        COLUMN_IMAGE +
        " TEXT, " +
        COLUMN_SEQUENCE_NUMBER +
        " INTEGER, " +
        COLUMN_TYPE +
        "  TEXT " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> servicesTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $SERVICES_TABLE_NAME'));
    return count;
  }

  static Future<int> insertServicesTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(SERVICES_TABLE_NAME, row);
  }
}
