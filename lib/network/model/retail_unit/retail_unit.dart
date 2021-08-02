import 'dart:convert';

import 'package:wayawaya/app/shop/model/sub_locations.dart';
import 'package:wayawaya/common/model/categories_model.dart';
import 'package:wayawaya/common/model/language_store.dart';

RetailUnit retailUnitFromJson(String str) =>
    RetailUnit.fromJson(json.decode(str));

String retailUnitToJson(RetailUnit data) => json.encode(data.toJson());

class RetailUnit {
  final String id;
  final String name;
  final List<LanguageStore> blogLink;
  final List<LanguageStore> description;
  final String status;
  final SubLocations subLocations;
  final String costCentreCode;
  final String ecommerceDetails;
  final List<Category> categoryList;
  final String favourite;

  RetailUnit(
      {this.id,
      this.name,
      this.blogLink,
      this.description,
      this.status,
      this.subLocations,
      this.costCentreCode,
      this.ecommerceDetails,
      this.categoryList,
      this.favourite});

  factory RetailUnit.fromJson(Map<String, dynamic> json) => RetailUnit(
        id: json["rid"],
        name: json["name"],
        blogLink: json["blog_link"] == null
            ? null
            : List<LanguageStore>.from(
                jsonDecode(json["blog_link"]).map(
                  (x) => LanguageStore.fromJson(x),
                ),
              ),
        description: json["description"] == null
            ? null
            : List<LanguageStore>.from(
                jsonDecode(json["description"]).map(
                  (x) => LanguageStore.fromJson(x),
                ),
              ),
        status: json["status"],
        costCentreCode: json["cost_centre_code"],
        ecommerceDetails: json["ecommerce_details"],
        categoryList: json["categoryList"] == null
            ? null
            : List<Category>.from(
                jsonDecode(json["categoryList"]).map(
                  (x) => Category.fromJson(x),
                ),
              ),
        subLocations: json["sub_locations"] == null
            ? null
            : SubLocations.fromJson(
                jsonDecode(json["sub_locations"]),
              ),
        favourite: json["favourite"],
      );

  Map<String, dynamic> toJson() => {
        "rid": id,
        "name": name,
        "blog_link": blogLink == null ? null : jsonEncode(blogLink),
        "description": description == null ? null : jsonEncode(description),
        "status": status,
        "cost_centre_code": costCentreCode,
        "ecommerce_details": ecommerceDetails,
        "sub_locations": subLocations == null ? null : subLocations.toJson(),
        "categoryList": categoryList == null ? null : jsonEncode(categoryList),
        "favourite": favourite,
      };

// @SerializedName("rid")
// public abstract String id();
// @SerializedName("name")
// public abstract String name();
// @SerializedName("blog_link")
// public abstract List<LanguageStore> blogLink();
// @SerializedName("description")
// public abstract List<LanguageStore> description();
// @SerializedName("status")
// public abstract String status();
// @SerializedName("sub_locations")
// public abstract SubLocations subLocations();
// @SerializedName("cost_centre_code")
// public abstract String costCentreCode();
// @SerializedName("ecommerce_details")
// public abstract String ecommerceDetails();
//
// @Nullable
// public abstract List<Category> categoryList();
// @SerializedName("favourite")
// public abstract int favourite();
}
