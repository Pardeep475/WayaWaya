import 'dart:convert';

LoyaltyNew loyaltyNewFromJson(String str) =>
    LoyaltyNew.fromJson(json.decode(str));

String loyaltyNewToJson(LoyaltyNew data) => json.encode(data.toJson());

class LoyaltyNew {
  String userId;
  String timestamp;
  String type;
  int points;
  String status;
  String description;
  String activationStatus;
  int openingBalance;
  int noOfTimes;
  String shopId;
  String campaignId;

  LoyaltyNew(
      {this.userId,
      this.timestamp,
      this.type,
      this.points,
      this.status,
      this.description,
      this.activationStatus,
      this.openingBalance,
      this.noOfTimes,
      this.shopId,
      this.campaignId});

  factory LoyaltyNew.fromJson(Map<String, dynamic> json) => LoyaltyNew(
        userId: json["user_id"],
        timestamp: json["event_timestamp"],
        type: json["type"],
        points: json["points"],
        status: json["status"],
        description: json["description"],
        activationStatus: json["activation_status"],
        openingBalance: json["opening_balance"],
        noOfTimes: json["no_of_times"],
        shopId: json["shop_id"],
        campaignId: json["campaign_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "event_timestamp": timestamp,
        "type": type,
        "points": points,
        "status": status,
        "description": description,
        "activation_status": activationStatus,
        "opening_balance": openingBalance,
        "no_of_times": noOfTimes,
        "shop_id": shopId,
        "campaign_id": campaignId,
      };
}
