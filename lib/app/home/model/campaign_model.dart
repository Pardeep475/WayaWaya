// To parse this JSON data, do
//
//     final campaign = campaignFromJson(jsonString);

import 'dart:convert';

import 'package:wayawaya/app/home/model/campaign_element.dart';

// List<Campaign> campaignFromJson(String str) => List<Campaign>.from(json.decode(str).map((x) => Campaign.fromJson(x)));
//
// String campaignToJson(List<Campaign> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Campaign campaignFromJson(String str) => Campaign.fromJson(json.decode(str));

String campaignToJson(Campaign data) => json.encode(data.toJson());

class Campaign {
  Campaign({
    // this.addBudget,
    // this.addBudgetRemaining,
    // this.addClickLimit,
    // this.addConversionLimit,
    // this.addImpressionLimit,
    // this.addPriotity,
    // this.addServerScript,
    // this.addServerUrl,
    // this.assetId,
    // this.b2XDatabaseListId,
    // this.campaignChannels,
    this.campaignElement,
    // this.costCentreCode,
    this.couponCode,
    this.couponValue,
    this.endDate,
    this.endTime,
    this.floorplanId,
    this.id,
    // this.imageSizeId,
    this.limitViewsPerSession,
    this.loyaltyOfferThreshold,
    // this.loyaltyOfferTimeout,
    this.loyaltyPoints,
    this.offerQrCode,
    // this.priceModel,
    this.publishDate,
    // this.ratePrice,
    // this.reviewerUserId,
    this.rid,
    this.startDate,
    this.startTime,
    this.status,
    // this.targetList,
    // this.timePeriod,
    // this.triggerZoneList,
    this.type,
    // this.viewResetCounter,
    this.voucher,
  });

  // dynamic addBudget;
  // dynamic addBudgetRemaining;
  // dynamic addClickLimit;
  // dynamic addConversionLimit;
  // dynamic addImpressionLimit;
  // dynamic addPriotity;
  // String addServerScript;
  // String addServerUrl;
  // String assetId;
  // String b2XDatabaseListId;
  // dynamic campaignChannels;
  dynamic campaignElement;
  // String costCentreCode;
  String couponCode;
  String couponValue;
  String endDate;
  String endTime;
  String floorplanId;
  String id;
  // String imageSizeId;
  int limitViewsPerSession;
  int loyaltyOfferThreshold;
  // dynamic loyaltyOfferTimeout;
  int loyaltyPoints;
  String offerQrCode;
  // String priceModel;
  String publishDate;
  // dynamic ratePrice;
  // String reviewerUserId;
  String rid;
  String startDate;
  String startTime;
  String status;
  // dynamic targetList;
  // String timePeriod;
  // dynamic triggerZoneList;
  dynamic type;
  // dynamic viewResetCounter;
  dynamic voucher;

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        // addBudget: json["add_budget"],
        // addBudgetRemaining: json["add_budget_remaining"],
        // addClickLimit: json["add_click_limit"],
        // addConversionLimit: json["add_conversion_limit"],
        // addImpressionLimit: json["add_impression_limit"],
        // addPriotity: json["add_priotity"],
        // addServerScript: json["add_server_script"],
        // addServerUrl: json["add_server_url"],
        // assetId: json["asset_id"],
        // b2XDatabaseListId: json["b2x_database_list_id"],
        // campaignChannels: json["campaign_channels"],
        campaignElement: json["campaign_element"]/* == null
            ? null
            : json["campaign_element"] is String
                ? CampaignElement.fromJson(jsonDecode(json["campaign_element"]))
                : CampaignElement.fromJson(json["campaign_element"]),
        costCentreCode: json["cost_centre_code"]*/,
        couponCode: json["coupon_code"],
        couponValue: json["coupon_value"],
        endDate: json["end_date"],
        endTime: json["end_time"],
        floorplanId: json["floorplan_id"],
        id: json["id"] ?? json["_id"],
        // imageSizeId: json["image_size_id"],
        limitViewsPerSession: json["limit_views_per_session"],
        loyaltyOfferThreshold: json["loyalty_offer_threshold"],
        // loyaltyOfferTimeout: json["loyalty_offer_timeout"],
        loyaltyPoints: json["loyalty_points"],
        offerQrCode: json["offer_qr_code"],
        // priceModel: json["price_model"],
        publishDate: json["publish_date"],
        // ratePrice: json["rate_price"],
        // reviewerUserId: json["reviewer_user_id"],
        rid: json["rid"],
        startDate: json["start_date"],
        startTime: json["start_time"],
        status: json["status"],
        // targetList: json["target_list"],
        // timePeriod: json["time_period"],
        // triggerZoneList: json["trigger_zone_list"],
        type: json["type"],
        // viewResetCounter: json["view_reset_counter"],
        voucher: json["voucher"],
      );

  Map<String, dynamic> toJson() => {
        // "add_budget": addBudget,
        // "add_budget_remaining": addBudgetRemaining,
        // "add_click_limit": addClickLimit,
        // "add_conversion_limit": addConversionLimit,
        // "add_impression_limit": addImpressionLimit,
        // "add_priotity": addPriotity,
        // "add_server_script": addServerScript,
        // "add_server_url": addServerUrl,
        // "asset_id": assetId,
        // "b2x_database_list_id": b2XDatabaseListId,
        // "campaign_channels": campaignChannels,
        "campaign_element":
            campaignElement == null ? null : jsonEncode(campaignElement),
        // "cost_centre_code": costCentreCode,
        "coupon_code": couponCode,
        "coupon_value": couponValue,
        "end_date": endDate,
        "end_time": endTime,
        "floorplan_id": floorplanId,
        "id": id,
        // "image_size_id": imageSizeId,
        "limit_views_per_session": limitViewsPerSession,
        "loyalty_offer_threshold": loyaltyOfferThreshold,
        // "loyalty_offer_timeout": loyaltyOfferTimeout,
        "loyalty_points": loyaltyPoints,
        "offer_qr_code": offerQrCode,
        // "price_model": priceModel,
        "publish_date": publishDate,
        // "rate_price": ratePrice,
        // "reviewer_user_id": reviewerUserId,
        "rid": rid,
        "start_date": startDate,
        "start_time": startTime,
        "status": status,
        // "target_list": targetList,
        // "time_period": timePeriod,
        // "trigger_zone_list": triggerZoneList,
        "type": type,
        // "view_reset_counter": viewResetCounter,
        "voucher": voucher,
      };
}
