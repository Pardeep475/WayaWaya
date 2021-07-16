import 'package:sqflite/sqflite.dart';

class TriggerZoneTable {
  static final TriggerZoneTable _triggerZoneTable =
      TriggerZoneTable._internal();

  factory TriggerZoneTable() {
    return _triggerZoneTable;
  }

  TriggerZoneTable._internal();

  static final String TRIGGER_ZONE_TABLE_NAME = "trigger_zones";

  static final String COLUMN_ID = "id";
  static final String COLUMN_RANGE = "range";
  static final String COLUMN_GEO_RADIUS = "geo_radius";
  static final String COLUMN_COOLDOWN_PERIOD = "cooldown_period";
  static final String COLUMN_DWELL_TIME = "dwell_time";
  static final String COLUMN_HANDLER = "handler";
  static final String COLUMN_TYPE = "type";
  static final String COLUMN_STATUS = "status";
  static final String COLUMN_I_BEACON = "i_beacon";
  static final String COLUMN_START_TIME = "start_time";
  static final String COLUMN_GEO_LOCATION = "geo_location";
  static final String COLUMN_DIRECTION = "direction";
  static final String COLUMN_END_TIME = "end_time";
  static final String COLUMN_MESSAGE_URL = "message_url";
  static final String COLUMN_UUID = "uuid";
  static final String COLUMN_MAJOR = "major";
  static final String COLUMN_MINOR = "minor";

  static Future triggerZoneCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        TRIGGER_ZONE_TABLE_NAME +
        " (" +
        COLUMN_ID +
        " TEXT PRIMARY  KEY,  " +
        COLUMN_RANGE +
        " TEXT  KEY,  " +
        COLUMN_GEO_RADIUS +
        " TEXT  KEY,  " +
        COLUMN_COOLDOWN_PERIOD +
        " TEXT  KEY,  " +
        COLUMN_DWELL_TIME +
        " TEXT  KEY,  " +
        COLUMN_HANDLER +
        " TEXT  KEY,  " +
        COLUMN_TYPE +
        " TEXT  KEY,  " +
        COLUMN_STATUS +
        " TEXT  KEY,  " +
        COLUMN_I_BEACON +
        " TEXT  KEY,  " +
        COLUMN_START_TIME +
        " TEXT  KEY,  " +
        COLUMN_GEO_LOCATION +
        " TEXT  KEY,  " +
        COLUMN_DIRECTION +
        " TEXT  KEY,  " +
        COLUMN_END_TIME +
        " TEXT  KEY,  " +
        COLUMN_MESSAGE_URL +
        " TEXT  KEY, " +
        COLUMN_UUID +
        " TEXT  KEY,  " +
        COLUMN_MAJOR +
        " TEXT  KEY,  " +
        COLUMN_MINOR +
        " TEXT  KEY " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> triggerZoneTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $TRIGGER_ZONE_TABLE_NAME'));
    return count;
  }

  static Future<int> insertTriggerZoneTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(TRIGGER_ZONE_TABLE_NAME, row);
  }
}
