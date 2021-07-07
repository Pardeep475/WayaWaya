import 'dart:convert';

import 'package:wayawaya/app/shop/model/color_codes.dart';
import 'package:wayawaya/common/model/language_store.dart';

List<ServiceModel> serviceModelFromJson(String str) => List<ServiceModel>.from(
    json.decode(str).map((x) => ServiceModel.fromJson(x)));

String serviceModelToJson(List<ServiceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceModel {
  ServiceModel({
    this.color,
    this.displayName,
    this.icon,
    this.image,
    this.sequenceNumber,
    this.serviceType,
    this.type,
  });

  dynamic color;
  List<LanguageStore> displayName;
  dynamic icon;
  dynamic image;
  int sequenceNumber;
  String serviceType;
  dynamic type;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        color: json["color"] == null ? null : json["color"],
        displayName: json["display_name"] == null
            ? null
            : List<LanguageStore>.from(jsonDecode(json["display_name"])
                .map((x) => LanguageStore.fromJson(x))),
        icon: json["icon"],
        image: json["image"],
        sequenceNumber: json["sequence_number"],
        serviceType: json["service_type"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "display_name": displayName == null
            ? null
            : List<dynamic>.from(displayName.map((x) => x.toJson())),
        "icon": icon,
        "image": image,
        "sequence_number": sequenceNumber,
        "service_type": serviceType,
        "type": type,
      };
}
