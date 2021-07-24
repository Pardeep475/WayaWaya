import 'dart:convert';

import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/shop/model/retail_unit_category.dart';
import 'package:wayawaya/common/model/language_store.dart';

import 'color_codes.dart';
import 'sub_locations.dart';

RetailWithCategory retailWithCategoryFromJson(String str) =>
    RetailWithCategory.fromJson(json.decode(str));

String retailWithCategoryToJson(RetailWithCategory data) =>
    json.encode(data.toJson());

class RetailWithCategory {
  final String id;
  final String name;
  final List<LanguageStore> description;

  final String categoryName;
  final List<RetailUnitCategory> retailUnitCategories;
  final ColorCodes color;

   String favourite;

   List<Campaign> campaigns;

  final SubLocations subLocations;

  RetailWithCategory(
      {this.id,
      this.name,
      this.description,
      this.categoryName,
      this.retailUnitCategories,
      this.color,
      this.favourite,
      this.campaigns,
      this.subLocations});

  factory RetailWithCategory.fromJson(Map<String, dynamic> json) =>
      RetailWithCategory(
        id: json["rid"],
        name: json["name"],
        description: json["description"] == null
            ? null
            : List<LanguageStore>.from(
                jsonDecode(json["description"]).map(
                  (x) => LanguageStore.fromJson(x),
                ),
              ),
        categoryName: json["category"],
        retailUnitCategories: json["categories"] == null
            ? null
            : List<RetailUnitCategory>.from(
                jsonDecode(json["categories"]).map(
                  (x) => RetailUnitCategory.fromJson(x),
                ),
              ),
        color: json["category_color"] == null
            ? null
            : ColorCodes.fromJson(
                jsonDecode(json["category_color"]),
              ),
        // subLocations: json["sub_locations"],
        subLocations: json["sub_locations"] == null
            ? null
            : SubLocations.fromJson(
                jsonDecode(json["sub_locations"]),
              ),
        favourite: json["favourite"],
        campaigns: json["campaigns"] == null
            ? null
            : List<Campaign>.from(
                jsonDecode(json["campaigns"]).map(
                  (x) => Campaign.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "rid": id,
        "name": name,
        "description": description == null
            ? null
            : List<dynamic>.from(
                description.map((x) => x.toJson()),
              ),
        "category": categoryName,
        "categories": retailUnitCategories == null
            ? null
            : List<dynamic>.from(
                retailUnitCategories.map((x) => x.toJson()),
              ),
        "category_color": color == null ? null : color.toJson(),
        "sub_locations": subLocations == null ? null : subLocations.toJson(),
        "favourite": favourite,
        "campaigns": campaigns == null
            ? null
            : List<dynamic>.from(
                campaigns.map((x) => x.toJson()),
              ),
      };
}
