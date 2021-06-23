import 'dart:convert';

import 'package:wayawaya/app/shop/model/polygon_model.dart';
import 'package:wayawaya/common/model/language_store.dart';

IsleDefinition isleDefinitionFromJson(String str) =>
    IsleDefinition.fromJson(json.decode(str));

String isleDefinitionToJson(IsleDefinition data) => json.encode(data.toJson());

class IsleDefinition {
  final List<LanguageStore> label;
  final String zoneId;
  final String reference;
  final PolygonModel shelfArea;

  IsleDefinition({this.label, this.zoneId, this.reference, this.shelfArea});

  factory IsleDefinition.fromJson(Map<String, dynamic> json) => IsleDefinition(
        label: json["lable"] == null
            ? null
            : List<LanguageStore>.from(
                json["lable"].map(
                  (x) => LanguageStore.fromJson(x),
                ),
              ),
        zoneId: json["zone_id"],
        reference: json["reference"],
        shelfArea: json["shelf_area"] == null
            ? null
            : PolygonModel.fromJson(
                json["shelf_area"],
              ),
      );

  Map<String, dynamic> toJson() => {
        "lable": label == null
            ? null
            : List<dynamic>.from(
                label.map((x) => x.toJson()),
              ),
        "zone_id": zoneId,
        "reference": reference,
        "shelf_area": shelfArea == null ? null : shelfArea.toJson(),
      };
}
