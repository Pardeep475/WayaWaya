import 'color_codes.dart';

class RetailUnitCategory {
  final String categoryId;
  final String parent;
  final String name;
  final ColorCodes categoryColor;

  RetailUnitCategory(
      {this.categoryId, this.parent, this.name, this.categoryColor});

  factory RetailUnitCategory.fromJson(Map<String, dynamic> json) =>
      RetailUnitCategory(
          categoryId: json["category_id"],
          parent: json["parent"],
          name: json["name"],
          categoryColor:
              json["color_category"] == null ? null : json["color_category"]);

  Map<String, dynamic> toJson() => {
        "color_category": categoryColor == null ? null : categoryColor.toJson(),
        "category_id": categoryId,
        "parent": parent,
        "name": name,
      };
}
