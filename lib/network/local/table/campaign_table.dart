import 'package:sqflite/sqflite.dart';

class CampaignTable {
  static final CampaignTable _campaignTable = CampaignTable._internal();

  factory CampaignTable() {
    return _campaignTable;
  }

  CampaignTable._internal();

  static final String CAMPAIGN_TABLE_NAME = "campaign";

  static final String COLUMN_ID = "id";
  static final String COLUMN_LOYALTY_OFFER_TIMEOUT = "loyalty_offer_timeout";
  static final String COLUMN_LIMIT_VIEWS_PER_SESSION =
      "limit_views_per_session";
  static final String COLUMN_CAMPAIGN_ELEMENT = "campaign_element";
  static final String COLUMN_VIEW_RESET_COUNTER = "view_reset_counter";
  static final String COLUMN_COUPON_VALUE = "coupon_value";
  static final String COLUMN_END_TIME = "end_time";
  static final String COLUMN_LOYALTY_POINTS = "loyalty_points";
  static final String COLUMN_ADD_PRIORITY = "add_priotity";
  static final String COLUMN_COST_CENTRE_CODE = "cost_centre_code";
  static final String COLUMN_ADD_CONVERSION_LIMIT = "add_conversion_limit";
  static final String COLUMN_ADD_BUDGET_REMAINING = "add_budget_remaining";
  static final String COLUMN_CAMPAIGN_CHANNELS = "campaign_channels";
  static final String COLUMN_ADD_CLICK_LIMIT = "add_click_limit";
  static final String COLUMN_TIME_PERIOD = "time_period";
  static final String COLUMN_ASSET_ID = "asset_id";
  static final String COLUMN_TRIGGER_ZONE_LIST = "trigger_zone_list";
  static final String COLUMN_OFFER_QR_CODE = "offer_qr_code";
  static final String COLUMN_END_DATE = "end_date";
  static final String COLUMN_COUPON_CODE = "coupon_code";
  static final String COLUMN_REVIEWER_USER_ID = "reviewer_user_id";
  static final String COLUMN_B2X_DATABASE_LIST_ID = "b2x_database_list_id";
  static final String COLUMN_LOYALTY_OFFER_THRESHOLD =
      "loyalty_offer_threshold";
  static final String COLUMN_ADD_BUDGET = "add_budget";
  static final String COLUMN_ADD_IMPRESSION_LIMIT = "add_impression_limit";
  static final String COLUMN_START_DATE = "start_date";
  static final String COLUMN_TARGET_LIST = "target_list";
  static final String COLUMN_STATUS = "status";
  static final String COLUMN_PRICE_MODEL = "price_model";
  static final String COLUMN_ADD_SERVER_SCRIPT = "add_server_script";
  static final String COLUMN_RATE_PRICE = "rate_price";
  static final String COLUMN_ADD_SERVER_URL = "add_server_url";
  static final String COLUMN_PUBLISH_DATE = "publish_date";
  static final String COLUMN_TYPE = "type";
  static final String COLUMN_START_TIME = "start_time";
  static final String COLUMN_VOUCHER = "voucher";
  static final String COLUMN_IMAGE_SIZE_ID = "image_size_id";
  static final String COLUMN_RID = "rid";
  static final String COLUMN_FLOORPLAN_ID = "floorplan_id";

  static Future campaignCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        CAMPAIGN_TABLE_NAME +
        " (" +
        COLUMN_ID +
        " TEXT PRIMARY KEY, " +
        COLUMN_LOYALTY_OFFER_TIMEOUT +
        " TEXT,  " +
        COLUMN_LIMIT_VIEWS_PER_SESSION +
        " TEXT  INTEGER,  " +
        COLUMN_CAMPAIGN_ELEMENT +
        " TEXT  ,  " +
        COLUMN_VIEW_RESET_COUNTER +
        " TEXT  INTEGER,  " +
        COLUMN_COUPON_VALUE +
        " TEXT ,  " +
        COLUMN_END_TIME +
        " TEXT ,  " +
        COLUMN_LOYALTY_POINTS +
        " TEXT  INTEGER,  " +
        COLUMN_ADD_PRIORITY +
        " TEXT  INTEGER,  " +
        COLUMN_COST_CENTRE_CODE +
        " TEXT  INTEGER,  " +
        COLUMN_ADD_CONVERSION_LIMIT +
        " TEXT  INTEGER,  " +
        COLUMN_ADD_BUDGET_REMAINING +
        " TEXT  REAL,  " +
        COLUMN_CAMPAIGN_CHANNELS +
        " TEXT  ,  " +
        COLUMN_ADD_CLICK_LIMIT +
        " TEXT  INTEGER,  " +
        COLUMN_TIME_PERIOD +
        " TEXT  ,  " +
        COLUMN_ASSET_ID +
        " TEXT ,  " +
        COLUMN_TRIGGER_ZONE_LIST +
        " TEXT  ,  " +
        COLUMN_OFFER_QR_CODE +
        " TEXT  ,  " +
        COLUMN_END_DATE +
        " TEXT  ,  " +
        COLUMN_COUPON_CODE +
        " TEXT  ,  " +
        COLUMN_REVIEWER_USER_ID +
        " TEXT  ,  " +
        COLUMN_B2X_DATABASE_LIST_ID +
        " TEXT  ,  " +
        COLUMN_LOYALTY_OFFER_THRESHOLD +
        " TEXT  INTEGER,  " +
        COLUMN_ADD_BUDGET +
        " TEXT  REAL,  " +
        COLUMN_ADD_IMPRESSION_LIMIT +
        " TEXT  INTEGER,  " +
        COLUMN_START_DATE +
        " TEXT  ,  " +
        COLUMN_TARGET_LIST +
        " TEXT  ,  " +
        COLUMN_STATUS +
        " TEXT  ,  " +
        COLUMN_PRICE_MODEL +
        " TEXT  ,  " +
        COLUMN_IMAGE_SIZE_ID +
        " TEXT  ,  " +
        COLUMN_ADD_SERVER_SCRIPT +
        " TEXT  ,  " +
        COLUMN_RATE_PRICE +
        " TEXT  REAL,  " +
        COLUMN_ADD_SERVER_URL +
        " TEXT  ,  " +
        COLUMN_PUBLISH_DATE +
        " TEXT  ,  " +
        COLUMN_TYPE +
        " TEXT  ,  " +
        COLUMN_START_TIME +
        " TEXT  ,  " +
        COLUMN_RID +
        " TEXT  ,  " +
        COLUMN_FLOORPLAN_ID +
        " TEXT  ,  " +
        COLUMN_VOUCHER +
        " TEXT  " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> campaignTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $CAMPAIGN_TABLE_NAME'));
    return count;
  }

  static Future<int> insertCampaignTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(CAMPAIGN_TABLE_NAME, row);
  }
}
