import 'dart:convert';

LoyaltyTemp loyaltyTempFromJson(String str) =>
    LoyaltyTemp.fromJson(json.decode(str));

String loyaltyTempToJson(LoyaltyTemp data) => json.encode(data.toJson());

class LoyaltyTemp {
  String timestamp;
  int totalMonthPoints;

  LoyaltyTemp({this.timestamp, this.totalMonthPoints});

  factory LoyaltyTemp.fromJson(Map<String, dynamic> json) => LoyaltyTemp(
        totalMonthPoints: json["totalMonthPoints"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "totalMonthPoints": totalMonthPoints,
        "timestamp": timestamp,
      };
}
