import 'dart:convert';

import 'package:wayawaya/common/model/language_store.dart';

ContactItem contactItemFromJson(String str) =>
    ContactItem.fromJson(json.decode(str));

String contactItemToJson(ContactItem data) => json.encode(data.toJson());

class ContactItem {
  final String itemData;
  final String iconId;
  final List<LanguageStore> displayLabel;
  final dynamic order;
  final String type;

  ContactItem(
      {this.itemData, this.iconId, this.displayLabel, this.order, this.type});

  factory ContactItem.fromJson(Map<String, dynamic> json) => ContactItem(
        itemData: json["item_data"],
        iconId: json["icon_id"],
        displayLabel: json["display_label"] == null
            ? null
            : List<LanguageStore>.from(
                json["display_label"].map(
                  (x) => LanguageStore.fromJson(x),
                ),
              ),
        order: json["order"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "item_data": itemData,
        "icon_id": iconId,
        "display_label": displayLabel == null
            ? null
            : List<dynamic>.from(
                displayLabel.map((x) => x.toJson()),
              ),
        "order": order,
        "type": type,
      };
}
