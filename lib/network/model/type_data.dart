import 'dart:convert';

import 'package:wayawaya/network/model/web.dart';

import 'message.dart';

TypeData typeDataFromJson(String str) => TypeData.fromJson(json.decode(str));

String typeDataToJson(TypeData data) => json.encode(data.toJson());

class TypeData {
  final String action;
  final String keywords;
  final String activity;
  final Message message;
  final Web web;

  TypeData({this.action, this.keywords, this.activity, this.message, this.web});

  factory TypeData.fromJson(Map<String, dynamic> json) => TypeData(
        action: json["action"],
        keywords: json["keywords"],
        activity: json["activity"],
        message: json["message"],
        web: json["web"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "keywords": keywords,
        "activity": activity,
        "message": message,
        "web": web,
      };
}
