import 'dart:convert';

import 'package:wayawaya/common/model/language_store.dart';

RetailUnitWrapper retailUnitWrapperFromJson(String str) => RetailUnitWrapper.fromJson(json.decode(str));

String retailUnitWrapperToJson(RetailUnitWrapper data) => json.encode(data.toJson());

class RetailUnitWrapper {
  RetailUnitWrapper({
    this.items,
    this.links,
    this.meta,
  });

  List<Item> items;
  RetailUnitWrapperLinks links;
  Meta meta;

  factory RetailUnitWrapper.fromJson(Map<String, dynamic> json) => RetailUnitWrapper(
    items: json["_items"] == null ? [] : List<Item>.from(json["_items"].map((x) => Item.fromJson(x))),
    links: json["_links"] == null ? null : RetailUnitWrapperLinks.fromJson(json["_links"]),
    meta: json["_meta"] == null ? null : Meta.fromJson(json["_meta"]),
  );

  Map<String, dynamic> toJson() => {
    "_items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
    "_links": links == null ? null : links.toJson(),
    "_meta":  meta == null ? null : meta.toJson(),
  };
}

class Item {
  Item({
    this.id,
    this.blogLink,
    this.costCentreCode,
    this.description,
    this.ecommerceDetails,
    this.name,
    this.status,
    this.subLocations,
    this.shopType,
    this.loyaltyConfig,
    this.updated,
    this.created,
    this.rid,
    this.links,
  });

  String id;
  List<LanguageStore> blogLink;
  CostCentreCode costCentreCode;
  List<LanguageStore> description;
  EcommerceDetails ecommerceDetails;
  String name;
  Status status;
  SubLocations subLocations;
  int shopType;
  LoyaltyConfig loyaltyConfig;
  String updated;
  String created;
  String rid;
  ItemLinks links;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["_id"],
    blogLink: json["blog_link"] == null ? null :List<LanguageStore>.from(json["blog_link"].map((x) => LanguageStore.fromJson(x))),
    costCentreCode: costCentreCodeValues.map[json["cost_centre_code"]],
    description: json["description"] == null ? null : List<LanguageStore>.from(json["description"].map((x) => LanguageStore.fromJson(x))),
    ecommerceDetails: ecommerceDetailsValues.map[json["ecommerce_details"]],
    name: json["name"],
    status: statusValues.map[json["status"]],
    subLocations: json["sub_locations"] == null ? null : SubLocations.fromJson(json["sub_locations"]),
    shopType: json["shop_type"],
    loyaltyConfig:json["loyalty_config"] == null ? null : LoyaltyConfig.fromJson(json["loyalty_config"]),
    updated: json["_updated"],
    created: json["_created"],
    rid: json["rid"],
    links: json["_links"] == null ? null : ItemLinks.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "blog_link":blogLink == null ? [] : List<dynamic>.from(blogLink.map((x) => x.toJson())),
    "cost_centre_code": costCentreCodeValues.reverse[costCentreCode],
    "description":description == null ? [] :  List<dynamic>.from(description.map((x) => x.toJson())),
    "ecommerce_details": ecommerceDetailsValues.reverse[ecommerceDetails],
    "name": name,
    "status": statusValues.reverse[status],
    "sub_locations": subLocations == null ? null : subLocations.toJson(),
    "shop_type": shopType,
    "loyalty_config": loyaltyConfig == null ? null : loyaltyConfig.toJson(),
    "_updated": updated,
    "_created": created,
    "rid": rid,
    "_links": links == null ? null :links.toJson(),
  };
}


enum Language { EN_US, FR, LANGUAGE_EN_US }

final languageValues = EnumValues({
  "en_US": Language.EN_US,
  "fr": Language.FR,
  "en-US": Language.LANGUAGE_EN_US
});

enum CostCentreCode { COST_CENTRE_CODE1 }

final costCentreCodeValues = EnumValues({
  "cost_centre_code1": CostCentreCode.COST_CENTRE_CODE1
});

enum EcommerceDetails { ECOMMERCE_DETAILS1 }

final ecommerceDetailsValues = EnumValues({
  "ecommerce_details1": EcommerceDetails.ECOMMERCE_DETAILS1
});

class ItemLinks {
  ItemLinks({
    this.self,
  });

  Last self;

  factory ItemLinks.fromJson(Map<String, dynamic> json) => ItemLinks(
    self: json["self"] == null ? null : Last.fromJson(json["self"]),
  );

  Map<String, dynamic> toJson() => {
    "self": self == null ? null : self.toJson(),
  };
}

class Last {
  Last({
    this.title,
    this.href,
  });

  Title title;
  String href;

  factory Last.fromJson(Map<String, dynamic> json) => Last(
    title: json["title"] == null ? null : titleValues.map[json["title"]],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ?  null : titleValues.reverse[title],
    "href": href,
  };
}

enum Title { RETAIL_UNITS_LISTS, LAST_PAGE, NEXT_PAGE, HOME, RETAIL_UNITS }

final titleValues = EnumValues({
  "home": Title.HOME,
  "last page": Title.LAST_PAGE,
  "next page": Title.NEXT_PAGE,
  "retailUnits": Title.RETAIL_UNITS,
  "retail_units Lists": Title.RETAIL_UNITS_LISTS
});

class LoyaltyConfig {
  LoyaltyConfig({
    this.limit,
    this.enabled,
    this.points,
  });

  int limit;
  bool enabled;
  List<dynamic> points;

  factory LoyaltyConfig.fromJson(Map<String, dynamic> json) => LoyaltyConfig(
    limit: json["limit"],
    enabled: json["enabled"],
    points: json["points"] == null ? [] : List<dynamic>.from(json["points"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "enabled": enabled,
    "points": points == null ? [] : List<dynamic>.from(points.map((x) => x)),
  };
}

enum Status { ACTIVE, HIDDEN, SUSPENDED }

final statusValues = EnumValues({
  "active": Status.ACTIVE,
  "hidden": Status.HIDDEN,
  "suspended": Status.SUSPENDED
});

class SubLocations {
  SubLocations({
    this.buildingId,
    this.carouselInside,
    this.carouselOutside,
    this.categoryId,
    this.contactItem,
    this.corridorViewId,
    this.floorId,
    this.floorplanId,
    this.isleDefinition,
    this.keywordList,
    this.locationXy,
    this.openingTimes,
    this.qrCodeId,
    this.qrCodeId2,
    this.shopNumber,
    this.shopOriginOrientation,
    this.shopOriginXy,
    this.logoId,
  });

  BuildingId buildingId;
  List<String> carouselInside;
  List<String> carouselOutside;
  List<String> categoryId;
  List<ContactItem> contactItem;
  List<CorridorViewId> corridorViewId;
  FloorId floorId;
  String floorplanId;
  IsleDefinition isleDefinition;
  List<LanguageStore> keywordList;
  NXy locationXy;
  OpeningTimes openingTimes;
  String qrCodeId;
  String qrCodeId2;
  String shopNumber;
  int shopOriginOrientation;
  NXy shopOriginXy;
  String logoId;

  factory SubLocations.fromJson(Map<String, dynamic> json) => SubLocations(
    buildingId: buildingIdValues.map[json["building_id"]],
    carouselInside: json["carousel_inside"] == null ? [] : List<String>.from(json["carousel_inside"].map((x) => x)),
    carouselOutside: json["carousel_outside"] == null ? [] : List<String>.from(json["carousel_outside"].map((x) => x)),
    categoryId: json["category_id"] == null ? [] : List<String>.from(json["category_id"].map((x) => x)),
    contactItem: json["contact_item"] == null ? [] : List<ContactItem>.from(json["contact_item"].map((x) => ContactItem.fromJson(x))),
    corridorViewId: json["corridor_view_id"] == null ? [] : List<CorridorViewId>.from(json["corridor_view_id"].map((x) => corridorViewIdValues.map[x])),
    floorId: floorIdValues.map[json["floor_id"]],
    floorplanId: json["floorplan_id"],
    isleDefinition: json["isle_definition"] == null ? null : IsleDefinition.fromJson(json["isle_definition"]),
    keywordList: json["keyword_list"] == null ? [] : List<LanguageStore>.from(json["keyword_list"].map((x) => LanguageStore.fromJson(x))),
    locationXy: json["location_xy"] == null ? null : NXy.fromJson(json["location_xy"]),
    openingTimes: json["opening_times"] == null ? null : OpeningTimes.fromJson(json["opening_times"]),
    qrCodeId: json["qr_code_id"],
    qrCodeId2: json["qr_code_id2"],
    shopNumber: json["shop_number"],
    shopOriginOrientation: json["shop_origin_orientation"],
    shopOriginXy: json["shop_origin_xy"] == null ? null : NXy.fromJson(json["shop_origin_xy"]),
    logoId: json["logo_id"],
  );

  Map<String, dynamic> toJson() => {
    "building_id": buildingIdValues.reverse[buildingId],
    "carousel_inside": carouselInside == null ? [] : List<dynamic>.from(carouselInside.map((x) => x)),
    "carousel_outside": carouselOutside == null ? [] : List<dynamic>.from(carouselOutside.map((x) => x)),
    "category_id": categoryId == null ? [] : List<dynamic>.from(categoryId.map((x) => x)),
    "contact_item": contactItem == null ? [] : List<dynamic>.from(contactItem.map((x) => x.toJson())),
    "corridor_view_id": corridorViewId == null ? [] : List<dynamic>.from(corridorViewId.map((x) => corridorViewIdValues.reverse[x])),
    "floor_id": floorIdValues.reverse[floorId],
    "floorplan_id": floorplanId,
    "isle_definition": isleDefinition == null ? null : isleDefinition.toJson(),
    "keyword_list": keywordList == null ? [] : List<dynamic>.from(keywordList.map((x) => x.toJson())),
    "location_xy": locationXy == null ? null : locationXy.toJson(),
    "opening_times": openingTimes == null ? null : openingTimes.toJson(),
    "qr_code_id": qrCodeId,
    "qr_code_id2": qrCodeId2,
    "shop_number": shopNumber,
    "shop_origin_orientation": shopOriginOrientation,
    "shop_origin_xy": shopOriginXy == null ? null : shopOriginXy.toJson(),
    "logo_id": logoId,
  };
}

enum BuildingId { B1, MALL_OF_MAURITIUS }

final buildingIdValues = EnumValues({
  "B1": BuildingId.B1,
  "Mall of Mauritius": BuildingId.MALL_OF_MAURITIUS
});

class ContactItem {
  ContactItem({
    this.itemData,
    this.iconId,
    this.displayLabel,
    this.order,
    this.type,
  });

  String itemData;
  IconId iconId;
  List<LanguageStore> displayLabel;
  int order;
  ContactItemType type;

  factory ContactItem.fromJson(Map<String, dynamic> json) => ContactItem(
    itemData: json["item_data"],
    iconId: iconIdValues.map[json["icon_id"]],
    displayLabel: json["display_label"] == null ? null : List<LanguageStore>.from(json["display_label"].map((x) => LanguageStore.fromJson(x))),
    order: json["order"],
    type: contactItemTypeValues.map[json["type"]],
  );

  Map<String, dynamic> toJson() => {
    "item_data": itemData,
    "icon_id": iconIdValues.reverse[iconId],
    "display_label": displayLabel == null ? [] : List<dynamic>.from(displayLabel.map((x) => x.toJson())),
    "order": order,
    "type": contactItemTypeValues.reverse[type],
  };
}

enum IconId { IC_FACEBOOK, IC_TWITTER, IC_INSTA, IC_WEB, IC_INSTAGRAM, IC_TEL, IC_EMAIL, IC_YOUTUBE, IC_TWEETER, IC_CART }

final iconIdValues = EnumValues({
  "ic_cart": IconId.IC_CART,
  "ic_email": IconId.IC_EMAIL,
  "ic_facebook": IconId.IC_FACEBOOK,
  "ic_insta": IconId.IC_INSTA,
  "ic_instagram": IconId.IC_INSTAGRAM,
  "ic_tel": IconId.IC_TEL,
  "ic_tweeter": IconId.IC_TWEETER,
  "ic_twitter": IconId.IC_TWITTER,
  "ic_web": IconId.IC_WEB,
  "ic_youtube": IconId.IC_YOUTUBE
});

enum ContactItemType { FACEBOOK, TWITTER, INSTAGRAM, WWW, TELEPHONE, EMAIL, YOUTUBE, CART }

final contactItemTypeValues = EnumValues({
  "cart": ContactItemType.CART,
  "email": ContactItemType.EMAIL,
  "facebook": ContactItemType.FACEBOOK,
  "instagram": ContactItemType.INSTAGRAM,
  "telephone": ContactItemType.TELEPHONE,
  "twitter": ContactItemType.TWITTER,
  "www": ContactItemType.WWW,
  "youtube": ContactItemType.YOUTUBE
});

enum CorridorViewId { ID_OF_VIEW1 }

final corridorViewIdValues = EnumValues({
  "id of view1": CorridorViewId.ID_OF_VIEW1
});

enum FloorId { F3, F5, F6, GROUND }

final floorIdValues = EnumValues({
  "F3": FloorId.F3,
  "F5": FloorId.F5,
  "F6": FloorId.F6,
  "Ground": FloorId.GROUND
});

class IsleDefinition {
  IsleDefinition({
    this.lable,
    this.reference,
    this.shelfArea,
    this.zoneId,
  });

  List<LanguageStore> lable;
  Reference reference;
  ShelfArea shelfArea;
  ZoneId zoneId;

  factory IsleDefinition.fromJson(Map<String, dynamic> json) => IsleDefinition(
    lable: json["lable"] == null ? [] : List<LanguageStore>.from(json["lable"].map((x) => LanguageStore.fromJson(x))),
    reference: referenceValues.map[json["reference"]],
    shelfArea: json["shelf_area"] == null ? null : ShelfArea.fromJson(json["shelf_area"]),
    zoneId: zoneIdValues.map[json["zone_id"]],
  );

  Map<String, dynamic> toJson() => {
    "lable": lable == null ? [] : List<dynamic>.from(lable.map((x) => x.toJson())),
    "reference": referenceValues.reverse[reference],
    "shelf_area": shelfArea == null ? null :shelfArea.toJson(),
    "zone_id": zoneIdValues.reverse[zoneId],
  };
}

enum Reference { ELECOURT_GRAYS_MU }

final referenceValues = EnumValues({
  "elecourt@grays.mu": Reference.ELECOURT_GRAYS_MU
});

class ShelfArea {
  ShelfArea({
    this.coordinates,
    this.type,
  });

  List<List<List<double>>> coordinates;
  ShelfAreaType type;

  factory ShelfArea.fromJson(Map<String, dynamic> json) => ShelfArea(
    coordinates: json["coordinates"] == null ? [] : List<List<List<double>>>.from(json["coordinates"].map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
    type: shelfAreaTypeValues.map[json["type"]],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
    "type": shelfAreaTypeValues.reverse[type],
  };
}

enum ShelfAreaType { POLYGON, TYPE_POLYGON }

final shelfAreaTypeValues = EnumValues({
  "polygon": ShelfAreaType.POLYGON,
  "Polygon": ShelfAreaType.TYPE_POLYGON
});

enum ZoneId { THE_2_A42_B289_DCB84_F9_E9_AFD061_A75_F4025_C, THE_4_D3_B4_D6_AEC544363962_E4005869_E2723 }

final zoneIdValues = EnumValues({
  "2a42b289dcb84f9e9afd061a75f4025c": ZoneId.THE_2_A42_B289_DCB84_F9_E9_AFD061_A75_F4025_C,
  "4d3b4d6aec544363962e4005869e2723": ZoneId.THE_4_D3_B4_D6_AEC544363962_E4005869_E2723
});

class NXy {
  NXy({
    this.coordinates,
    this.type,
  });

  List<double> coordinates;
  LocationXyType type;

  factory NXy.fromJson(Map<String, dynamic> json) => NXy(
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    type: locationXyTypeValues.map[json["type"]],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates.map((x) => x)),
    "type": locationXyTypeValues.reverse[type],
  };
}

enum LocationXyType { POINT }

final locationXyTypeValues = EnumValues({
  "Point": LocationXyType.POINT
});

class OpeningTimes {
  OpeningTimes({
    this.closeTime,
    this.description,
    this.endDate,
    this.openTime,
    this.period,
    this.startDate,
    this.title,
    this.type,
  });

  String closeTime;
  List<LanguageStore> description;
  String endDate;
  String openTime;
  List<LanguageStore> period;
  String startDate;
  List<LanguageStore> title;
  OpeningTimesType type;

  factory OpeningTimes.fromJson(Map<String, dynamic> json) => OpeningTimes(
    closeTime: json["close_time"],
    description: json["description"] == null ? [] : List<LanguageStore>.from(json["description"].map((x) => LanguageStore.fromJson(x))),
    endDate: json["end_date"],
    openTime:  json["open_time"],
    period: json["period"] == null ? [] :List<LanguageStore>.from(json["period"].map((x) => LanguageStore.fromJson(x))),
    startDate: json["start_date"],
    title: json["title"] == null ? [] :List<LanguageStore>.from(json["title"].map((x) => LanguageStore.fromJson(x))),
    type: openingTimesTypeValues.map[json["type"]],
  );

  Map<String, dynamic> toJson() => {
    "close_time": closeTime,
    "description": description == null ? [] : List<dynamic>.from(description.map((x) => x.toJson())),
    "end_date": endDate,
    "open_time": openTime,
    "period": period == null ? [] : List<dynamic>.from(period.map((x) => x.toJson())),
    "start_date": startDate,
    "title": title == null ? [] : List<dynamic>.from(title.map((x) => x.toJson())),
    "type": openingTimesTypeValues.reverse[type],
  };
}

enum OpeningTimesType { WEEK_DAY }

final openingTimesTypeValues = EnumValues({
  "week_day": OpeningTimesType.WEEK_DAY
});

class RetailUnitWrapperLinks {
  RetailUnitWrapperLinks({
    this.parent,
    this.self,
    this.next,
    this.last,
  });

  Last parent;
  Last self;
  Last next;
  Last last;

  factory RetailUnitWrapperLinks.fromJson(Map<String, dynamic> json) => RetailUnitWrapperLinks(
    parent: json["parent"] == null ? null : Last.fromJson(json["parent"]),
    self: json["self"] == null ? null : Last.fromJson(json["self"]),
    next: json["next"] == null ? null : Last.fromJson(json["next"]),
    last: json["last"] == null ? null : Last.fromJson(json["last"]),
  );

  Map<String, dynamic> toJson() => {
    "parent": parent == null ? null :parent.toJson(),
    "self": self == null ? null :self.toJson(),
    "next": next == null ? null :next.toJson(),
    "last": last == null ? null :last.toJson(),
  };
}

class Meta {
  Meta({
    this.page,
    this.maxResults,
    this.total,
  });

  int page;
  int maxResults;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    maxResults: json["max_results"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "max_results": maxResults,
    "total": total,
  };
}

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