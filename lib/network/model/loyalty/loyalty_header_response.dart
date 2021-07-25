import 'dart:convert';

LoyaltyHeaderResponse loyaltyHeaderResponseFromJson(String str) =>
    LoyaltyHeaderResponse.fromJson(json.decode(str));

String loyaltyHeaderResponseToJson(LoyaltyHeaderResponse data) =>
    json.encode(data.toJson());

class LoyaltyHeaderResponse {
  String timestamp;
  int totalMonthPoints;
  String month;

  LoyaltyHeaderResponse({this.timestamp, this.totalMonthPoints, this.month});

  factory LoyaltyHeaderResponse.fromJson(Map<String, dynamic> json) =>
      LoyaltyHeaderResponse(
        totalMonthPoints: json["total_month_point"],
        timestamp: json["timestamp"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "total_month_point": totalMonthPoints,
        "timestamp": timestamp,
        "month": month,
      };
}
