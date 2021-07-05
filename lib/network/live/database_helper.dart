import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelperCommon {
  static final _dbName = 'wayawayadatabase.db';
  static final _dbVersion = 1;

  // main menu permission
  static final _mainMenuPermissionTableName = 'main_menu_permission_table_name';
  static final mainMenuPermissionIconName = 'main_menu_permission_icon_name';
  static final mainMenuPermissionTitle = 'main_menu_permission_icon_name';
  static final mainMenuPermissionBackgroundColor =
      'main_menu_permission_back_color';
  static final mainMenuPermissionIconCode = 'main_menu_permission_icon_code';

  // All Malls
  static final _allMallTableName = 'all_mall_table_name';
  static final allMallName = 'name';
  static final allMallLabel = 'label';
  static final allMallIdentifier = 'identifier';
  static final allMallKey = 'key';
  static final allMallGeofence = 'geofence';
  static final allMallDbName = 'db_name';
  static final allMallLogoBase64 = 'logo_base64';
  static final allMallIBeaconUid = 'ibeacon_uuid';
  static final allMallVenueData = 'venue_data';
  static final allMallActive = 'active';

  // preference category
  static final _preferenceCategoryTableName = 'preference_category_table_name';
  static final preferenceCategoryParent = 'parent';
  static final preferenceCategoryCategoryId = 'categoryId';
  static final preferenceCategoryName = 'name';
  static final preferenceCategoryLabel = 'label';
  static final preferenceCategorySubscription = 'subscription';

  // campaign
  static final _campaignTableName = 'campaign_table_name';
  static final campaignAddBudget = 'addBudget';
  static final campaignAddBudgetRemaining = 'addBudgetRemaining';
  static final campaignAddClickLimit = 'addClickLimit';
  static final campaignAddConversionLimit = 'addConversionLimit';
  static final campaignAddImpressionLimit = 'addImpressionLimit';
  static final campaignAddPriority = 'addPriotity';
  static final campaignAddServerScript = 'addServerScript';
  static final campaignAddServerUrl = 'addServerUrl';
  static final campaignAssetId = 'assetId';
  static final campaignB2XDatabaseListId = 'b2XDatabaseListId';
  static final campaignCampaignChannels = 'campaignChannels';
  static final campaignCampaignElement = 'campaignElement';
  static final campaignCostCenterCode = 'costCentreCode';
  static final campaignCouponCode = 'couponCode';
  static final campaignCouponValue = 'couponValue';
  static final campaignEndDate = 'endDate';
  static final campaignEndTime = 'endTime';
  static final campaignFloorPlanId = 'floorplanId';
  static final campaignUDID = 'udid';
  static final campaignImageSizeId = 'imageSizeId';
  static final campaignLimitViewsPerSession = 'limitViewsPerSession';
  static final campaignLoyaltyOfferThreshold = 'loyaltyOfferThreshold';
  static final campaignLoyaltyOfferTimeout = 'loyaltyOfferTimeout';
  static final campaignLoyaltyPoints = 'loyaltyPoints';
  static final campaignOfferQrCode = 'offerQrCode';
  static final campaignPriceModel = 'priceModel';
  static final campaignPublishDate = 'publishDate';
  static final campaignRatePrice = 'ratePrice';
  static final campaignReviewerUserId = 'reviewerUserId';
  static final campaignRId = 'rid';
  static final campaignStartDate = 'startDate';
  static final campaignStartTime = 'startTime';
  static final campaignStatus = 'status';
  static final campaignTargetList = 'targetList';
  static final campaignTimePeriod = 'timePeriod';
  static final campaignTriggerZoneList = 'triggerZoneList';
  static final campaignType = 'type';
  static final campaignViewResetCounter = 'viewResetCounter';
  static final campaignVoucher = 'voucher';

  static final _id = 'ID';
  static final loadNumber = 'LOAD_NUMBER';
  static final invoiceCount = 'INVOICE_COUNT';
  static final invoicePath = 'INVOICE_PATH';
  static final invoicePdfPath = 'INVOICE_PDF_PATH';
  static final bolCount = 'BOL_COUNT';
  static final bolPath = 'BOL_PATH';
  static final bolPdfPath = 'BOL_PDF_PATH';
  static final rateConfirmationCount = 'RATE_CONFIRMATION_COUNT';
  static final rateConfirmationPath = 'RATE_CONFIRMATION_PATH';
  static final rateConfirmationPdfPath = 'RATE_CONFIRMATION_PDF_PATH';
  static final lumperReceiptCount = 'LUMPER_RECEIPT_COUNT';
  static final lumperReceiptPath = 'LUMPER_RECEIPT_PATH';
  static final lumperReceiptPdfPath = 'LUMPER_RECEIPT_PDF_PATH';
  static final otherCount = 'OTHER_COUNT';
  static final otherPath = 'OTHER_PATH';
  static final otherPdfPath = 'OTHER_PDF_PATH';
  static final isEmailSent = 'IS_EMAIL_SENT';

  // preference category
  static final _retailUnitTableName = 'retail_unit_table_name';
  static final retailUnitId = 'retail_unit_id';
  static final retailUnitName = 'retail_unit_name';
  static final retailUnitDescription = 'retail_unit_description';
  static final retailUnitCategoryName = 'retail_unit_category_name';
  static final retailUnitCategories = 'retail_unit_categories';
  static final retailUnitColor = 'retail_unit_color';
  static final retailUnitFavourite = 'retail_unit_favourite';
  static final retailUnitSubLocation = 'retail_unit_sub_location';

  // make it singleton class
  DataBaseHelperCommon._privateConstructor();

  static final DataBaseHelperCommon instance =
      DataBaseHelperCommon._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      _database.close();
      _database = null;
    }

    _database = await _initiateDataBase();
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
    await retailUnitCreateTable(db, version);
    await campaignCreateTable(db, version);
    // mainMenuPermissionCreateTable(db, version);
    // allMallCreateTable(db, version);
    // preferenceCategoryCreateTable(db, version);
  }

  // create table for menu permission
  Future mainMenuPermissionCreateTable(Database db, int version) async {
    db.execute('''
    CREATE TABLE $_mainMenuPermissionTableName(
   $_id INTEGER PRIMARY KEY AUTOINCREMENT,
   $mainMenuPermissionIconName  TEXT DEFAULT \'\',
   $mainMenuPermissionTitle TEXT DEFAULT \'\',
   $mainMenuPermissionBackgroundColor TEXT DEFAULT \'\',
   $mainMenuPermissionIconCode TEXT DEFAULT \'\',)
    ''');
  }

  // create table for malls data
  Future allMallCreateTable(Database db, int version) async {
    db.execute('''
    CREATE TABLE $_allMallTableName(
   $_id INTEGER PRIMARY KEY AUTOINCREMENT,
   $allMallName  TEXT DEFAULT \'\',
   $allMallLabel TEXT DEFAULT \'\',
   $allMallIdentifier TEXT DEFAULT \'\',
   $allMallKey TEXT DEFAULT \'\',
   $allMallGeofence TEXT DEFAULT \'\',
   $allMallDbName TEXT DEFAULT \'\',
   $allMallLogoBase64 TEXT DEFAULT \'\',
   $allMallIBeaconUid TEXT DEFAULT \'\',
   $allMallVenueData TEXT DEFAULT \'\',
   $allMallActive TEXT DEFAULT \'\',
   )
    ''');
  }

  // create table for preference category
  Future preferenceCategoryCreateTable(Database db, int version) async {
    db.execute('''
    CREATE TABLE $_preferenceCategoryTableName(
   $_id INTEGER PRIMARY KEY AUTOINCREMENT,
   $preferenceCategoryParent  TEXT DEFAULT \'\',
   $preferenceCategoryCategoryId TEXT DEFAULT \'\',
   $preferenceCategoryName TEXT DEFAULT \'\',
   $preferenceCategoryLabel TEXT DEFAULT \'\',
   $preferenceCategorySubscription INT DEFAULT 0,
   )
    ''');
  }

  static Future retailUnitCreateTable(Database db, int version) async {
    db.execute('''
    CREATE TABLE IF NOT EXISTS $_retailUnitTableName (
   $_id INTEGER PRIMARY KEY AUTOINCREMENT,
   $retailUnitId  TEXT DEFAULT \'\',
   $retailUnitName TEXT DEFAULT \'\',
   $retailUnitDescription TEXT DEFAULT \'\',
   $retailUnitCategoryName TEXT DEFAULT \'\',
   $retailUnitCategories  TEXT DEFAULT \'\',
   $retailUnitColor  TEXT DEFAULT \'\',
   $retailUnitFavourite  TEXT DEFAULT \'\',
   $retailUnitSubLocation  TEXT DEFAULT \'\',
   );
    ''');
  }

  static Future<int> getRetailUnitLength() async {
    Database _db = await instance.database;

    (await _db.query('sqlite_master', columns: ['type', 'name']))
        .forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await _db.rawQuery('SELECT COUNT(*) FROM $_retailUnitTableName'));
    return count;
  }

  static Future<int> insertRetailUnitLength(Map<String, dynamic> row) async {
    Database _db = await instance.database;
    return await _db.insert(_retailUnitTableName, row);
  }

  // create table for campaign Future
  static Future campaignCreateTable(Database db, int version) async {
    db.execute('''
  CREATE TABLE $_campaignTableName(
 $_id INTEGER PRIMARY KEY AUTOINCREMENT,
 $campaignAddBudget  TEXT DEFAULT \'\',
 $campaignAddBudgetRemaining TEXT DEFAULT \'\',
 $campaignAddClickLimit INT DEFAULT 0,
 $campaignAddConversionLimit INT DEFAULT 0,
 $campaignAddImpressionLimit INT DEFAULT 0,
 $campaignAddPriority INT DEFAULT 0,
 $campaignAddServerScript TEXT DEFAULT \'\',
 $campaignAddServerUrl TEXT DEFAULT \'\',
 $campaignAssetId TEXT DEFAULT \'\',
 $campaignB2XDatabaseListId TEXT DEFAULT \'\',
 $campaignCampaignChannels TEXT DEFAULT \'\',
 $campaignCampaignElement TEXT DEFAULT \'\',
 $campaignCostCenterCode TEXT DEFAULT \'\',
 $campaignCouponCode TEXT DEFAULT \'\',
 $campaignCouponValue TEXT DEFAULT \'\',
 $campaignEndDate TEXT DEFAULT \'\',
 $campaignEndTime TEXT DEFAULT \'\',
 $campaignFloorPlanId TEXT DEFAULT \'\',
 $campaignUDID TEXT DEFAULT \'\',
 $campaignImageSizeId TEXT DEFAULT \'\',
 $campaignLimitViewsPerSession INT DEFAULT 0,
 $campaignLoyaltyOfferThreshold INT DEFAULT 0,
 $campaignLoyaltyOfferTimeout TEXT DEFAULT \'\',
 $campaignLoyaltyPoints INT DEFAULT 0,
 $campaignOfferQrCode TEXT DEFAULT \'\',
 $campaignPriceModel TEXT DEFAULT \'\',
 $campaignPublishDate TEXT DEFAULT \'\',
 $campaignRatePrice TEXT DEFAULT \'\',
 $campaignReviewerUserId TEXT DEFAULT \'\',
 $campaignRId TEXT DEFAULT \'\',
 $campaignStartDate TEXT DEFAULT \'\',
 $campaignStartTime TEXT DEFAULT \'\',
 $campaignStatus TEXT DEFAULT \'\',
 $campaignTargetList TEXT DEFAULT \'\',
 $campaignTimePeriod TEXT DEFAULT \'\',
 $campaignTriggerZoneList TEXT DEFAULT \'\',
 $campaignType TEXT DEFAULT \'\',
 $campaignViewResetCounter INT DEFAULT 0,
 $campaignVoucher TEXT DEFAULT \'\',
 )
  ''');
  }

// Future<int> insert(Map<String, dynamic> row) async {
//   Database _db = await instance.database;
//   return await _db.insert(_tableName, row);
// }
//
// Future<List<Map<String, dynamic>>> queryItem(int loadNumber) async {
//   debugPrint('database_testing:-  loadNumber :-   $loadNumber');
//   Database _db = await instance.database;
//   // return await _db.query(_tableName, where: '$loadNumber = ?', whereArgs: [loadNumber]);
//   return await _db
//       .rawQuery('SELECT * FROM $_tableName WHERE LOAD_NUMBER = $loadNumber');
// }
//
// Future<int> update(Map<String, dynamic> row) async {
//   Database _db = await instance.database;
//   int loadNumberValue = row[loadNumber];
//   return await _db.update(_tableName, row,
//       where: '$loadNumber = ?', whereArgs: [loadNumberValue]);
// }
//
// Future<int> delete(int loadNumber) async {
//   Database _db = await instance.database;
//   return await _db
//       .delete(_tableName, where: '$loadNumber = ?', whereArgs: [loadNumber]);
// }
}
