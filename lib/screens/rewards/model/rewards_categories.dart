// To parse this JSON data, do
//
//     final rewardsCategory = rewardsCategoryFromJson(jsonString);

import 'dart:convert';

List<RewardsCategory> rewardsCategoryFromJson(String str) =>
    List<RewardsCategory>.from(
        json.decode(str).map((x) => RewardsCategory.fromJson(x)));

String rewardsCategoryToJson(List<RewardsCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RewardsCategory {
  RewardsCategory(
      {this.categoryColor,
      this.categoryId,
      this.description,
      this.display,
      this.iconId,
      this.id,
      this.label,
      this.links,
      this.name,
      this.parent,
      this.subscription,
      this.type,
      this.isSelected});

  String categoryColor;
  String categoryId;
  String description;
  int display;
  String iconId;
  String id;
  String label;
  String links;
  String name;
  Parent parent;
  int subscription;
  Type type;
  bool isSelected;

  factory RewardsCategory.fromJson(Map<String, dynamic> json) =>
      RewardsCategory(
        categoryColor: json["category_color"],
        categoryId: json["category_id"],
        description: json["description"],
        display: json["display"],
        iconId: json["icon_id"],
        id: json["id"],
        label: json["label"],
        links: json["links"],
        name: json["name"],
        parent: parentValues.map[json["parent"]],
        subscription: json["subscription"],
        type: typeValues.map[json["type"]],
        isSelected: false,
      );

  Map<String, dynamic> toJson() => {
        "category_color": categoryColor,
        "category_id": categoryId,
        "description": description,
        "display": display,
        "icon_id": iconId,
        "id": id,
        "label": label,
        "links": links,
        "name": name,
        "parent": parentValues.reverse[parent],
        "subscription": subscription,
        "type": typeValues.reverse[type],
      };
}

enum Parent {
  EMPTY,
  THE_70919502_F78_C4_B66940_D7715_E6_FC929_A,
  AA90_D5_F5_B3044_A17_A2_F8_AF19993_EAD5_D
}

final parentValues = EnumValues({
  "aa90d5f5b3044a17a2f8af19993ead5d":
      Parent.AA90_D5_F5_B3044_A17_A2_F8_AF19993_EAD5_D,
  "": Parent.EMPTY,
  "70919502f78c4b66940d7715e6fc929a":
      Parent.THE_70919502_F78_C4_B66940_D7715_E6_FC929_A
});

enum Type { MAIN, SUB }

final typeValues = EnumValues({"main": Type.MAIN, "sub": Type.SUB});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
