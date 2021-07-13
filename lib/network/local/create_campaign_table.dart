import 'package:sqflite/sqflite.dart';

class CreateCampaignTable {
  static final CreateCampaignTable _createCampaignTable =
      CreateCampaignTable._internal();

  factory CreateCampaignTable() {
    return _createCampaignTable;
  }

  CreateCampaignTable._internal();

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

  // create table for campaign Future
  static Future campaignCreateTable(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $_campaignTableName(
 ID INTEGER PRIMARY KEY AUTOINCREMENT,
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
}
