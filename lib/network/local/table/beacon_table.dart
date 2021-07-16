import 'package:sqflite/sqflite.dart';

class BeaconTable {
  static final BeaconTable _beaconTable = BeaconTable._internal();

  factory BeaconTable() {
    return _beaconTable;
  }

  BeaconTable._internal();

  static final String BEACON_TABLE_NAME = "beacon";

  static final String COLUMN_ID = "id";
  static final String COLUMN_UUID = "uuid";
  static final String COLUMN_MAJOR = "major";
  static final String COLUMN_MINOR = "minor";

  static Future beaconCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        BEACON_TABLE_NAME +
        " (" +
        COLUMN_ID +
        " TEXT PRIMARY KEY," +
        COLUMN_UUID +
        " TEXT NOT NULL," +
        COLUMN_MAJOR +
        " INTEGER NOT NULL," +
        COLUMN_MINOR +
        " INTEGER NOT NULL" +
        " );";

    await db.execute(createTable);
  }

  static Future<int> beaconTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $BEACON_TABLE_NAME'));
    return count;
  }

  static Future<int> insertBeaconTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(BEACON_TABLE_NAME, row);
  }
}
