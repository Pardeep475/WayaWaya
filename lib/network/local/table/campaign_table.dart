import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';

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
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $CAMPAIGN_TABLE_NAME'));
    return count;
  }

  static Future<int> insertCampaignTable(
      {Database db, Map<String, dynamic> row, String campaignId}) async {
    if (campaignId == null) {
      try{
        return db.insert(CAMPAIGN_TABLE_NAME, row);
      }catch(e){
        debugPrint('database_insert:-  $e');
      }
    } else {
      dynamic campaign = await getCampaignById(db, campaignId);
      if (campaign == null || campaign.length == 0 || campaign.length < 0) {
        try{
          return db.insert(CAMPAIGN_TABLE_NAME, row);
        }catch(e){
          debugPrint('database_insert:-  $e');
        }
      } else {
        return db.update(CAMPAIGN_TABLE_NAME, row,
            where: '$COLUMN_ID = ?', whereArgs: [campaignId]);
      }
    }

    // await db.transaction((txn) async {
    //   var batch = txn.batch();
    //   if (campaignId == null) {
    //     batch.insert(CAMPAIGN_TABLE_NAME, row);
    //   } else {
    //     // dynamic campaign = await getCampaignById(db, campaignId);
    //     dynamic campaign = txn.update(CAMPAIGN_TABLE_NAME, row,
    //         where: '$COLUMN_ID = ?', whereArgs: [campaignId]);
    //     if (campaign == null) {
    //       batch.insert(CAMPAIGN_TABLE_NAME, row);
    //     } else {
    //       batch.update(CAMPAIGN_TABLE_NAME, row,
    //           where: '$COLUMN_ID = ?', whereArgs: [campaignId]);
    //     }
    //   }
    //   await batch.commit();
    // });
    // return 0;
  }

  static Future<int> updateCampaignTable(
      Database db, Map<String, dynamic> row, String campaignId) async {
    try{
      return await db.update(CAMPAIGN_TABLE_NAME, row,
          where: '$COLUMN_ID = ?', whereArgs: [campaignId]);
    }catch(e){
      debugPrint('database_update:-  $e');
    }

  }

  static Future<dynamic> getCampaignById(Database db, String campaignId) async {
    return await db.query(CAMPAIGN_TABLE_NAME,
        where: '$COLUMN_ID = ?', whereArgs: [campaignId]);
  }

  static Future<List<Campaign>> getLauncherCampaignData(
      {Database db,
      String campaignType,
      int limit,
      int offset,
      String searchText,
      String rid,
      String publish_date}) async {
    String whereClause = "";
    String searchQueryCondition = "";
    String offerForRetailUnitCondition = "";
    if (searchText != null && searchText.isNotEmpty) {
      searchQueryCondition = " AND ( " +
          CampaignTable.COLUMN_CAMPAIGN_ELEMENT +
          " LIKE '%" +
          searchText +
          "%' ) ";
    }

    if (rid != null && rid.isNotEmpty) {
      offerForRetailUnitCondition = " AND ( rid LIKE '%" + rid + "%') ";
    }
    if (campaignType.isNotEmpty) {
      whereClause = " WHERE type='" +
          campaignType +
          "' AND " +
          CampaignTable.COLUMN_STATUS +
          "='approved' ";
    } else {
      whereClause = " WHERE " + CampaignTable.COLUMN_STATUS + "='approved' ";
    }

    whereClause += " AND publish_date <= '" + publish_date + "'";

    String query = "SELECT *, '' as shop_name FROM " +
        CAMPAIGN_TABLE_NAME +
        " " +
        whereClause +
        searchQueryCondition +
        offerForRetailUnitCondition +
        " AND voucher NOT LIKE '%\"is_coupon\": true%'" +
        " ORDER BY " +
        COLUMN_START_DATE +
        " ASC" +
        " LIMIT " +
        limit.toString() +
        " OFFSET " +
        offset.toString();

    List<Map> data;

    debugPrint('campaign_query:-  $query');

    await db.transaction((txn) async {
      data = await txn.rawQuery(query);
    });
    debugPrint('database_testing:-   ${data.length}');
    // debugPrint('database_testing:-   $data');
    List<Campaign> _mallList = [];
    data.forEach((element) {
      _mallList.add(Campaign.fromJson(element));
    });
    return _mallList;
  }

  static Future<List<Campaign>> getCampaignOffersAndEvents(
      {Database db,
      String campaingType,
      final int limit,
      final int offset,
      final String searchText,
      final String rid,
      final String publish_date,
      bool isCoupon}) async {
    String whereClause = "";
    String strType = "";
    String searchQueryCondition = "";
    String offerForRetailUnitCondition = "";
    if (searchText != null && searchText.isNotEmpty) {
      searchQueryCondition = " AND ( " + CampaignTable.COLUMN_CAMPAIGN_ELEMENT + " LIKE '%" + searchText + "%' ) ";
    }
    if (rid != null && rid.isNotEmpty) {
      offerForRetailUnitCondition = " AND ( rid LIKE '%" + rid + "%') ";
    }

    if (campaingType.isNotEmpty) {
      whereClause = " WHERE type='" + campaingType + "' AND " + CampaignTable.COLUMN_STATUS + "='approved' ";
    } else {
      whereClause = " WHERE " + CampaignTable.COLUMN_STATUS + "='approved' ";
    }

    if (campaingType.isNotEmpty && campaingType == "offer") {
      strType = " AND (voucher NOT  LIKE '%\"is_coupon\": true%'  AND  voucher  NOT LIKE '%\"is_coupon\":true%')";
    } else {
      strType = " AND voucher NOT LIKE '%\"is_coupon\": " + isCoupon.toString() + "%'";
    }

    whereClause += " AND publish_date <= '" + publish_date + "'";

    String query = "SELECT *, '' as shop_name FROM " + CampaignTable.CAMPAIGN_TABLE_NAME + " " +
        whereClause +
        searchQueryCondition +
        offerForRetailUnitCondition +
        strType +
        " ORDER BY " + CampaignTable.COLUMN_START_DATE + " ASC" +
        " LIMIT " + limit.toString() + " OFFSET " + offset.toString();

    List<Map> data;

    debugPrint('campaign_query:-  $query');

    await db.transaction((txn) async {
      data = await txn.rawQuery(query);
    });
    debugPrint('database_testing:-   ${data.length}');
    // debugPrint('database_testing:-   $data');
    List<Campaign> _mallList = [];
    data.forEach((element) {
      _mallList.add(Campaign.fromJson(element));
    });
    return _mallList;
  }


  static Future<List<Campaign>> getRetailUnitOffer(
      {Database db}) async {

    String query = "SELECT *, '' as shop_name FROM " + CampaignTable.CAMPAIGN_TABLE_NAME
        + " WHERE " + CampaignTable.COLUMN_TYPE
        + " = 'offer' ";

    debugPrint('query_campaign:-  $query');

    List<Map> data;

    await db.transaction((txn) async {
      data = await txn.rawQuery(query);
    });

    debugPrint('database_testing:-   ${data.length}');
    debugPrint('database_testing:-   $data');
    List<Campaign> _mallList = [];
    data.forEach((element) {
      _mallList.add(Campaign.fromJson(element));
    });
    data.map((e) => debugPrint('database_testing:-    $e'));
    // _mallList.sort();
    return _mallList;
  }


}
