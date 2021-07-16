import 'package:sqflite/sqflite.dart';

class OmniChannelItemTable {
  static final OmniChannelItemTable _omniChannelItemTable =
      OmniChannelItemTable._internal();

  factory OmniChannelItemTable() {
    return _omniChannelItemTable;
  }

  OmniChannelItemTable._internal();

  static final String OMNI_CHANNEL_TABLE_NAME = "omni_channel";
  static final String COLUMN_ID = "id";
  static final String COLUMN_OID = "oid";
  static final String COLUMN_STATUS = "status";
  static final String COLUMN_MESSAGE_LIMIT = "message_limit";
  static final String COLUMN_DESCRIPTION = "description";
  static final String COLUMN_PRESENCE = "presence";
  static final String COLUMN_COST_CENTER_CODE = "cost_center_code";
  static final String COLUMN_NUISANCE_LIMIT = "nuisance_limit";
  static final String COLUMN_NUISANCE_PERIOD = "nuisance_period";
  static final String COLUMN_ZONE_TAG = "zone_tag";
  static final String COLUMN_TRIGGER_ZONE_ID = "trigger_zone_id";
  static final String COLUMN_SUB_TYPE = "sub_type";
  static final String COLUMN_NUISENCE_RULE = "nuisence_rule";
  static final String COLUMN_ANALYTIC_TAG = "analytic_tag";
  static final String COLUMN_COOL_DOWN_PERIOD = "cool_down_period";
  static final String COLUMN_TYPE = "type";
  static final String COLUMN_GUARD_TIME_START = "guard_time_start";
  static final String COLUMN_THEME = "theme";
  static final String COLUMN_DOWNLOAD_URL = "download_url";
  static final String COLUMN_ANALYTICS_TRIGGERS = "analytics_triggers";
  static final String COLUMN_URL1 = "url1";
  static final String COLUMN_URL2 = "url2";
  static final String COLUMN_IMAGE_SIZE_ID = "image_size_id";
  static final String COLUMN_COOL_DOWN_TIME = "cool_down_time";
  static final String COLUMN_GUARD_TIME_STOP = "guard_time_stop";

  static Future omniChannelCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        OMNI_CHANNEL_TABLE_NAME +
        " (" +
        COLUMN_OID +
        " TEXT PRIMARY KEY, " +
        COLUMN_ID +
        "  TEXT, " +
        COLUMN_STATUS +
        "  TEXT, " +
        COLUMN_MESSAGE_LIMIT +
        "  INTEGER, " +
        COLUMN_DESCRIPTION +
        "  TEXT, " +
        COLUMN_PRESENCE +
        "  INTEGER, " +
        COLUMN_COST_CENTER_CODE +
        "  TEXT, " +
        COLUMN_NUISANCE_LIMIT +
        "  INTEGER, " +
        COLUMN_NUISANCE_PERIOD +
        "  TEXT, " +
        COLUMN_ZONE_TAG +
        "  TEXT, " +
        COLUMN_TRIGGER_ZONE_ID +
        "  TEXT, " +
        COLUMN_SUB_TYPE +
        "  TEXT, " +
        COLUMN_NUISENCE_RULE +
        "  INTEGER, " +
        COLUMN_ANALYTIC_TAG +
        "  TEXT, " +
        COLUMN_COOL_DOWN_PERIOD +
        "  TEXT, " +
        COLUMN_TYPE +
        "  TEXT, " +
        COLUMN_GUARD_TIME_START +
        "  TEXT, " +
        COLUMN_THEME +
        "  TEXT, " +
        COLUMN_DOWNLOAD_URL +
        "  TEXT, " +
        COLUMN_ANALYTICS_TRIGGERS +
        "  TEXT, " +
        COLUMN_URL1 +
        "  TEXT, " +
        COLUMN_URL2 +
        "  TEXT, " +
        COLUMN_IMAGE_SIZE_ID +
        "  TEXT, " +
        COLUMN_COOL_DOWN_TIME +
        "  TEXT, " +
        COLUMN_GUARD_TIME_STOP +
        "  TEXT " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> omniChannelTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $OMNI_CHANNEL_TABLE_NAME'));
    return count;
  }

  static Future<int> insertOmniChannelTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(OMNI_CHANNEL_TABLE_NAME, row);
  }
}
