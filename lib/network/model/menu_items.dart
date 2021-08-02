import 'dart:convert';

import 'package:wayawaya/common/model/language_store.dart';
import 'package:wayawaya/network/model/resource_data.dart';

import 'icon.dart';
import 'type_data.dart';

class MenuItems {
  final List<LanguageStore> displayName;
  final String serviceType;
  final int sequenceNumber;
  final Icon icon;
  final ResourceData color;
  final ResourceData image;
  final TypeData typeData;

  MenuItems(
      {this.displayName,
      this.serviceType,
      this.sequenceNumber,
      this.icon,
      this.color,
      this.image,
      this.typeData});

  factory MenuItems.fromJson(Map<String, dynamic> json) => MenuItems(
        displayName: json["display_name"],
        serviceType: json["service_type"],
        sequenceNumber: json["sequence_number"],
        icon: json["icon"],
        color: json["color"],
        image: json["image"],
        typeData: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "display_name": displayName == null ? null : jsonEncode(displayName),
        "service_type": serviceType,
        "sequence_number": sequenceNumber,
        "icon": icon == null ? null : jsonEncode(icon),
        "color": color == null ? null : jsonEncode(color),
        "image": image == null ? null : jsonEncode(image),
        "type": typeData == null ? null : jsonEncode(typeData),
      };
}
