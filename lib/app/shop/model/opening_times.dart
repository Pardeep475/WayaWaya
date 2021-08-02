import 'dart:convert';

import 'package:wayawaya/common/model/language_store.dart';

OpeningTimes openingTimeFromJson(String str) =>
    OpeningTimes.fromJson(json.decode(str));

String openingTimeToJson(OpeningTimes data) => json.encode(data.toJson());

class OpeningTimes {
  final List<LanguageStore> period;
  final List<LanguageStore> title;
  final List<LanguageStore> description;
  final String openTime;
  final String startDate;
  final String endDate;
  final String closeTime;

  OpeningTimes(
      {this.period,
      this.title,
      this.description,
      this.openTime,
      this.startDate,
      this.endDate,
      this.closeTime});

  factory OpeningTimes.fromJson(Map<String, dynamic> json) => OpeningTimes(
        period: json["period"] == null
            ? null
            : List<LanguageStore>.from(
                json["period"].map(
                  (x) => LanguageStore.fromJson(x),
                ),
              ),
        title: json["title"] == null
            ? null
            : List<LanguageStore>.from(
                json["title"].map(
                  (x) => LanguageStore.fromJson(x),
                ),
              ),
        description: json["description"] == null
            ? null
            : List<LanguageStore>.from(
                json["description"].map(
                  (x) => LanguageStore.fromJson(x),
                ),
              ),
        openTime: json["open_time"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        closeTime: json["close_time"],
      );

  Map<String, dynamic> toJson() => {
        "period": period == null ? null : jsonEncode(period),
        "title": title == null ? null : jsonEncode(title),
        "description": description == null ? null : jsonEncode(description),
        "open_time": openTime,
        "start_date": startDate,
        "end_date": endDate,
        "close_time": closeTime,
      };
}
