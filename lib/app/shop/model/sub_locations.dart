import 'dart:convert';

import 'package:wayawaya/common/model/language_store.dart';

import 'contact_item.dart';
import 'image_properties.dart';
import 'isle_definition.dart';
import 'opening_times.dart';
import 'point.dart';

SubLocations subLocationsFromJson(String str) =>
    SubLocations.fromJson(json.decode(str));

String subLocationsToJson(SubLocations data) => json.encode(data.toJson());

class SubLocations {
  final String qrCodeId2;
  final ImageProperties logoId;
  final dynamic shopOriginOrientation;
  final String buildingId;
  final OpeningTimes openingTimes;

  final List<ContactItem> contactItem;

  final IsleDefinition isleDefinition;

  final Point locationXy;

  final List<String> categoryId;

  final String qrCodeId;
  final Point shopOriginXy;
  final List<String> carouselOutside;
  final String shopNumber;
  final List<String> corridorViewId;
  final String floorplanId;
  final List<String> carouselInside;
  final String floorId;
  final List<LanguageStore> keywordList;

  SubLocations(
      {this.qrCodeId2,
      this.logoId,
      this.shopOriginOrientation,
      this.buildingId,
      this.openingTimes,
      this.contactItem,
      this.isleDefinition,
      this.locationXy,
      this.categoryId,
      this.qrCodeId,
      this.shopOriginXy,
      this.carouselOutside,
      this.shopNumber,
      this.corridorViewId,
      this.floorplanId,
      this.carouselInside,
      this.floorId,
      this.keywordList});

  factory SubLocations.fromJson(Map<String, dynamic> json) => SubLocations(
        qrCodeId2: json["qr_code_id2"],
        logoId: json["logo_id"] == null
            ? null
            : ImageProperties.fromJson(
                json["logo_id"],
              ),
        shopOriginOrientation: json["shop_origin_orientation"],
        buildingId: json["building_id"],
        openingTimes: json["opening_times"] == null
            ? null
            : OpeningTimes.fromJson(
                json["opening_times"],
              ),
        contactItem: json["contact_item"] == null
            ? null
            : List<ContactItem>.from(
                json["contact_item"].map(
                  (x) => ContactItem.fromJson(x),
                ),
              ),
        isleDefinition: json["isle_definition"] == null
            ? null
            : IsleDefinition.fromJson(
                json["isle_definition"],
              ),
        locationXy: json["location_xy"] == null
            ? null
            : Point.fromJson(
                json["location_xy"],
              ),
        categoryId: json["category_id"] == null
            ? null
            : List<String>.from(
                json["category_id"].map(
                  (x) => x,
                ),
              ),
        qrCodeId: json["qr_code_id"],
        shopOriginXy: json["shop_origin_xy"] == null
            ? null
            : Point.fromJson(
                json["shop_origin_xy"],
              ),
        carouselOutside: json["carousel_outside"] == null
            ? null
            : List<String>.from(
                json["carousel_outside"].map(
                  (x) => x,
                ),
              ),
        shopNumber: json["shop_number"],
        corridorViewId: json["corridor_view_id"] == null
            ? null
            : List<String>.from(
                json["corridor_view_id"].map(
                  (x) => x,
                ),
              ),
        carouselInside: json["carousel_inside"] == null
            ? null
            : List<String>.from(
                json["carousel_inside"].map(
                  (x) => x,
                ),
              ),
        floorplanId: json["floorplan_id"],
        floorId: json["floor_id"],
        keywordList: json["keyword_list"] == null
            ? null
            : List<LanguageStore>.from(
                json["keyword_list"].map(
                  (x) => LanguageStore.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "qr_code_id2": qrCodeId2,
        "logo_id": logoId == null ? null : logoId.toJson(),
        "shop_origin_orientation": shopOriginOrientation,
        "building_id": buildingId,
        "opening_times": openingTimes == null ? null : openingTimes.toJson(),
        "contact_item": contactItem == null
            ? null
            : List<dynamic>.from(
                contactItem.map((x) => x.toJson()),
              ),
        "isle_definition":
            isleDefinition == null ? null : isleDefinition.toJson(),
        "location_xy": locationXy == null ? null : locationXy.toJson(),
        "category_id": categoryId == null
            ? null
            : List<dynamic>.from(
                categoryId.map((x) => x),
              ),
        "qr_code_id": qrCodeId,
        "shop_origin_xy": shopOriginXy == null ? null : shopOriginXy.toJson(),
        "carousel_outside": carouselOutside == null
            ? null
            : List<dynamic>.from(
                carouselOutside.map((x) => x),
              ),
        "shop_number": shopNumber,
        "corridor_view_id": corridorViewId,
        "corridor_view_id": corridorViewId == null
            ? null
            : List<dynamic>.from(
                corridorViewId.map((x) => x),
              ),
        "carousel_inside": carouselInside == null
            ? null
            : List<dynamic>.from(
                carouselInside.map((x) => x),
              ),
        "floorplan_id": floorplanId,
        "floor_id": floorId,
        "keyword_list": keywordList == null
            ? null
            : List<dynamic>.from(
                keywordList.map((x) => x.toJson()),
              ),
      };
}
