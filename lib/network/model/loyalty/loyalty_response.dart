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
    // this.created,
    // this.updated,
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
    // this.links,
    // this.noOfTimes,
  });

  String id;

  // String created;
  // String updated;
  String eventTimestamp;
  String userId;
  String campaignId;
  String type;
  int points;
  String status;
  String description;
  String activationStatus;
  int openingBalance;
  int amount;
  String code;
  String beacon;

  // ItemLinks links;
  // int noOfTimes;

  factory LoyaltyData.fromJson(Map<String, dynamic> json) => LoyaltyData(
        id: json["_id"],
        // created: json["_created"],
        // updated: json["_updated"],
        eventTimestamp: json["event_timestamp"],
        userId: json["user_id"],
        campaignId: json["campaign_id"],
        type: json["type"],
        points: json["points"],
        status: json["status"],
        description: json["description"],
        activationStatus: json["activation_status"],
        openingBalance: json["opening_balance"],
        amount: json["amount"] == null ? null : json["amount"],
        code: json["code"] == null ? null : json["code"],
        beacon: json["beacon"] == null ? null : json["beacon"],
        // links: json["_links"] == null ? null : ItemLinks.fromJson(json["_links"]),
        // noOfTimes: json["no_of_times"] == null ? null : json["no_of_times"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        // "_created": created,
        // "_updated": updated,
        "event_timestamp": eventTimestamp,
        "user_id": userId,
        "campaign_id": campaignId == null ? null : campaignId,
        "type": type,
        "points": points,
        "status": status,
        "description": description,
        "activation_status": activationStatus,
        "opening_balance": openingBalance,
        "amount": amount == null ? null : amount,
        "code": code == null ? null : code,
        "beacon": beacon == null ? null : beacon,
        // "_links": links == null ? null :links.toJson(),
        // "no_of_times": noOfTimes == null ? null : noOfTimes,
      };
}

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

  String title;
  String href;

  factory Last.fromJson(Map<String, dynamic> json) => Last(
        title: json["title"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "href": href,
      };
}

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
        parent: json["parent"] == null ? null : Last.fromJson(json["parent"]),
        self: json["self"] == null ? null : Last.fromJson(json["self"]),
        next: json["next"] == null ? null : Last.fromJson(json["next"]),
        last: json["last"] == null ? null : Last.fromJson(json["last"]),
      );

  Map<String, dynamic> toJson() => {
        "parent": parent == null ? null : parent.toJson(),
        "self": self == null ? null : self.toJson(),
        "next": next == null ? null : next.toJson(),
        "last": last == null ? null : last.toJson(),
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
