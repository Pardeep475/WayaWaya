import 'package:sqflite/sqflite.dart';

class VenuesTable {
  static final VenuesTable _venuesTable = VenuesTable._internal();

  factory VenuesTable() {
    return _venuesTable;
  }

  VenuesTable._internal();

  static final String VENUES_TABLE_NAME = "venues";

  static final String COLUMN_MALLNAME = "mallname";
  static final String COLUMN_MALLLOCATION = "malllocation";
  static final String COLUMN_UUID = "uuid";
  static final String COLUMN_GEOFENCE = "geofence";

  static Future venuesCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        VENUES_TABLE_NAME +
        " (" +
        COLUMN_MALLNAME +
        " TEXT PRIMARY KEY, " +
        COLUMN_MALLLOCATION +
        " TEXT, " +
        COLUMN_UUID +
        " TEXT, " +
        COLUMN_GEOFENCE +
        " TEXT" +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> venuesTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $VENUES_TABLE_NAME'));
    return count;
  }

  static Future<int> insertVenuesTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(VENUES_TABLE_NAME, row);
  }
}
