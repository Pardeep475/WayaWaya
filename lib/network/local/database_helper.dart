import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/utils.dart';
import 'table/beacon_table.dart';
import 'table/campaign_table.dart';
import 'table/categories_table.dart';
import 'table/cinemas_table.dart';
import 'table/event_table.dart';
import 'table/favourites.dart';
import 'table/in_the_mall_table.dart';
import 'table/loyalty_table.dart';
import 'table/mall_profiles_table.dart';
import 'table/offer_table.dart';
import 'table/omni_channel_item_table.dart';
import 'table/parking_table.dart';
import 'table/retail_unit_category_map.dart';
import 'table/retail_unit_table.dart';
import 'table/services_table.dart';
import 'table/temp_loyalty_user_point_table.dart';
import 'table/the_mall_table.dart';
import 'table/themes_table.dart';
import 'table/trigger_zone_table.dart';
import 'table/venues_table.dart';

class DataBaseHelperCommon {
  static final _dbName = 'wayawayadatabase.db';
  static final _dbVersion = 1;
  static final _id = 'ID';

  // make it singleton class
  DataBaseHelperCommon._privateConstructor();

  static final DataBaseHelperCommon instance =
      DataBaseHelperCommon._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initiateDataBase();
    }

    return _database;
  }

  static _initiateDataBase() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path, _dbName);
      return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
    } catch (e) {
      debugPrint('database exception:-    $e');
    }
  }

  static Future _onCreate(Database db, int version) async {
    await BeaconTable.beaconCreateTable(db: db, version: version);
    await CampaignTable.campaignCreateTable(db: db, version: version);
    await CategoriesTable.categoryCreateTable(db: db, version: version);
    await CinemasTable.cinemasCreateTable(db: db, version: version);
    await EventTable.eventCreateTable(db: db, version: version);
    await Favourites.favouritesCreateTable(db: db, version: version);
    await InTheMallTable.inTheMallCreateTable(db: db, version: version);
    await LoyaltyTable.loyaltyCreateTable(db: db, version: version);
    await MallProfilesTable.mallProfileCreateTable(db: db, version: version);
    await OfferTable.offerTableCreateTable(db: db, version: version);
    await OmniChannelItemTable.omniChannelCreateTable(db: db, version: version);
    await ParkingTable.parkingCreateTable(db: db, version: version);
    await RetailUnitCategoryMap.retailUnitCategoryMapCreateTable(
        db: db, version: version);
    await RetailUnitTable.retailUnitCreateTable(db: db, version: version);
    await ServicesTable.servicesCreateTable(db: db, version: version);
    await TempLoyaltyUserPointTable.tempLoyaltyUserPointCreateTable(
        db: db, version: version);
    await TheMallTable.theMallCreateTable(db: db, version: version);
    await ThemesTable.themesCreateTable(db: db, version: version);
    await TriggerZoneTable.triggerZoneCreateTable(db: db, version: version);
    await VenuesTable.venuesCreateTable(db: db, version: version);
  }

  // all malls data
  static Future<int> getAllMallsLength() async {
    Database _db = await instance.database;
    (await _db.query('sqlite_master', columns: ['type', 'name']))
        .forEach((row) {
      print(row.values);
    });
    // int count = await CreateAllMallTable.getAllMallsLength(db: _db);
    return 0;
  }

  static Future<int> insertAllMalls(Map<String, dynamic> row) async {
    Database _db = await instance.database;
    (await _db.query('sqlite_master', columns: ['type', 'name']))
        .forEach((row) {
      print(row.values);
    });
    return 0;
    // Database _db = await instance.database;
    // return await CreateAllMallTable.insertAllMalls(db: _db, row: row);
  }

  // campaign all queries

  static Future<int> getCampaignLength() async {
    Database _db = await instance.database;
    return await CampaignTable.campaignTableLength(db: _db);
  }

  static Future<int> insertCampaign(
      Map<String, dynamic> row, String campaignID) async {
    Database _db = await instance.database;
    return await CampaignTable.insertCampaignTable(
        db: _db, row: row, campaignId: campaignID);
  }

  static Future<List<Campaign>> getLauncherCampaignData(
      {String campaignType,
      int limit,
      int offset,
      String searchText,
      String rid,
      String publish_date}) async {
    Database _db = await instance.database;
    return await CampaignTable.getLauncherCampaignData(
        db: _db,
        limit: limit,
        offset: offset,
        rid: rid,
        searchText: searchText,
        publish_date:
            Utils.getStringFromDate(DateTime.now(), AppString.DATE_FORMAT),
        campaignType: campaignType);
  }

  static Future<List<Campaign>> getCampaignOffersAndEvents(
      {final String campaingType,
      final int limit,
      final int offset,
      final String searchText,
      final String rid,
      final String publish_date,
      bool isCoupon}) async {
    Database _db = await instance.database;
    return await CampaignTable.getCampaignOffersAndEvents(
        db: _db,
        limit: limit,
        offset: offset,
        rid: rid,
        searchText: searchText,
        publish_date:
            Utils.getStringFromDate(DateTime.now(), AppString.DATE_FORMAT),
        campaingType: campaingType,
        isCoupon: isCoupon);
  }

  static Future deleteData() async {
    Database _db = await instance.database;
    await _db.delete(CampaignTable.CAMPAIGN_TABLE_NAME);
    await _db.delete(BeaconTable.BEACON_TABLE_NAME);
    await _db.delete(CategoriesTable.CATEGORY_TABLE_NAME);
    await _db.delete(CinemasTable.CINEMAS_TABLE_NAME);
    await _db.delete(EventTable.EVENT_TABLE_NAME);
    await _db.delete(Favourites.FAVOURITES_TABLE_NAME);
    await _db.delete(InTheMallTable.IN_THE_MALL_TABLE_NAME);
    await _db.delete(LoyaltyTable.LOYALTY_TABLE_NAME);
    await _db.delete(MallProfilesTable.TABLE_NAME_MALL_PROFILE);
    await _db.delete(OfferTable.OFFER_TABLE_NAME);
    await _db.delete(OmniChannelItemTable.OMNI_CHANNEL_TABLE_NAME);
    await _db.delete(ParkingTable.PARKING_TABLE_NAME);
    await _db.delete(RetailUnitCategoryMap.RETAIL_CATEGORY_MAP_TABLE_NAME);
    await _db.delete(RetailUnitTable.RETAIL_UNIT_TABLE_NAME);
    await _db.delete(ServicesTable.SERVICES_TABLE_NAME);
    await _db.delete(TempLoyaltyUserPointTable.LOYALTY_USER_POINT_TABLE_NAME);
    await _db.delete(TheMallTable.THE_MALL_TABLE_NAME);
    await _db.delete(ThemesTable.THEME_TABLE_NAME);
    await _db.delete(TriggerZoneTable.TRIGGER_ZONE_TABLE_NAME);
    return await _db.delete(VenuesTable.VENUES_TABLE_NAME);
  }

  static Future deleteDataBase() async {
    Database _db = await instance.database;
    await _db.close();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await deleteDatabase(path);
  }
}
