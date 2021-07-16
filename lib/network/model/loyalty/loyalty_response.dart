// To parse this JSON data, do
//
//     final loyaltyResponse = loyaltyResponseFromJson(jsonString);

import 'dart:convert';

LoyaltyResponse loyaltyResponseFromJson(String str) =>
    LoyaltyResponse.fromJson(json.decode(str));

String loyaltyResponseToJson(LoyaltyResponse data) =>
    json.encode(data.toJson());

class LoyaltyResponse {
  LoyaltyResponse({
    this.items,
    this.links,
    this.meta,
  });

  List<LoyaltyData> items;
  LoyaltyResponseLinks links;
  Meta meta;

  factory LoyaltyResponse.fromJson(Map<String, dynamic> json) =>
      LoyaltyResponse(
        items: json["_items"] == null
            ? null
            : List<LoyaltyData>.from(
                json["_items"].map((x) => LoyaltyData.fromJson(x))),
        links: json["_links"] == null
            ? null
            : LoyaltyResponseLinks.fromJson(json["_links"]),
        meta: json["_meta"] == null ? null : Meta.fromJson(json["_meta"]),
      );

  Map<String, dynamic> toJson() => {
        "_items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
        "_links": links == null ? null : links.toJson(),
        "_meta": meta == null ? null : meta.toJson(),
      };
}

class LoyaltyData {
  LoyaltyData({
    this.id,
    this.created,
    this.updated,
    this.eventTimestamp,
    this.userId,
    this.campaignId,
    this.type,
    this.points,
    this.status,
    this.description,
    this.activationStatus,
    this.openingBalance,
    this.amount,
    this.code,
    this.beacon,
    this.links,
    this.noOfTimes,
  });

  String id;
  String created;
  String updated;
  String eventTimestamp;
  UserId userId;
  String campaignId;
  Type type;
  int points;
  Status status;
  String description;
  ActivationStatus activationStatus;
  int openingBalance;
  int amount;
  String code;
  String beacon;
  ItemLinks links;
  int noOfTimes;

  factory LoyaltyData.fromJson(Map<String, dynamic> json) => LoyaltyData(
        id: json["_id"],
        created: json["_created"],
        updated: json["_updated"],
        eventTimestamp: json["event_timestamp"],
        userId: userIdValues.map[json["user_id"]],
        campaignId: json["campaign_id"] == null ? null : json["campaign_id"],
        type: typeValues.map[json["type"]],
        points: json["points"],
        status: statusValues.map[json["status"]],
        description: json["description"],
        activationStatus: activationStatusValues.map[json["activation_status"]],
        openingBalance: json["opening_balance"],
        amount: json["amount"] == null ? null : json["amount"],
        code: json["code"] == null ? null : json["code"],
        beacon: json["beacon"] == null ? null : json["beacon"],
        links: json["_links"] == null ? null : ItemLinks.fromJson(json["_links"]),
        noOfTimes: json["no_of_times"] == null ? null : json["no_of_times"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "_created": created,
        "_updated": updated,
        "event_timestamp": eventTimestamp,
        "user_id": userIdValues.reverse[userId],
        "campaign_id": campaignId == null ? null : campaignId,
        "type": typeValues.reverse[type],
        "points": points,
        "status": statusValues.reverse[status],
        "description": description,
        "activation_status": activationStatusValues.reverse[activationStatus],
        "opening_balance": openingBalance,
        "amount": amount == null ? null : amount,
        "code": code == null ? null : code,
        "beacon": beacon == null ? null : beacon,
        "_links": links == null ? null :links.toJson(),
        "no_of_times": noOfTimes == null ? null : noOfTimes,
      };
}

enum ActivationStatus { ACTIVATED }

final activationStatusValues =
    EnumValues({"activated": ActivationStatus.ACTIVATED});

class ItemLinks {
  ItemLinks({
    this.self,
  });

  Last self;

  factory ItemLinks.fromJson(Map<String, dynamic> json) => ItemLinks(
        self: Last.fromJson(json["self"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self.toJson(),
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
        title: titleValues.map[json["title"]],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "title": titleValues.reverse[title],
        "href": href,
      };
}

enum Title {
  LOYALTY_TRANSACTIONS_LISTS,
  LAST_PAGE,
  NEXT_PAGE,
  HOME,
  LOYALTY_TRANSACTIONS
}

final titleValues = EnumValues({
  "home": Title.HOME,
  "last page": Title.LAST_PAGE,
  "loyaltyTransactions": Title.LOYALTY_TRANSACTIONS,
  "loyaltyTransactions Lists": Title.LOYALTY_TRANSACTIONS_LISTS,
  "next page": Title.NEXT_PAGE
});

enum Status { OPEN }

final statusValues = EnumValues({"open": Status.OPEN});

enum Type { REGISTER, APP_OPEN, VIEW_OFFER }

final typeValues = EnumValues({
  "app_open": Type.APP_OPEN,
  "register": Type.REGISTER,
  "view_offer": Type.VIEW_OFFER
});

enum UserId { C22_A887_E20444_C479_B073_E6_F12515_D0_E }

final userIdValues = EnumValues({
  "c22a887e20444c479b073e6f12515d0e":
      UserId.C22_A887_E20444_C479_B073_E6_F12515_D0_E
});

class LoyaltyResponseLinks {
  LoyaltyResponseLinks({
    this.parent,
    this.self,
    this.next,
    this.last,
  });

  Last parent;
  Last self;
  Last next;
  Last last;

  factory LoyaltyResponseLinks.fromJson(Map<String, dynamic> json) =>
      LoyaltyResponseLinks(
        parent: Last.fromJson(json["parent"]),
        self: Last.fromJson(json["self"]),
        next: Last.fromJson(json["next"]),
        last: Last.fromJson(json["last"]),
      );

  Map<String, dynamic> toJson() => {
        "parent": parent.toJson(),
        "self": self.toJson(),
        "next": next.toJson(),
        "last": last.toJson(),
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
