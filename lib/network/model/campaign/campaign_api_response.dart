// To parse this JSON data, do
//
//     final campaignApiResponse = campaignApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wayawaya/app/home/model/campaign_model.dart';

CampaignApiResponse campaignApiResponseFromJson(String str) =>
    CampaignApiResponse.fromJson(json.decode(str));

String campaignApiResponseToJson(CampaignApiResponse data) =>
    json.encode(data.toJson());

class CampaignApiResponse {
  CampaignApiResponse({
    this.items,
    this.links,
    this.meta,
  });

  List<Campaign> items;
  CampaignApiResponseLinks links;
  Meta meta;

  factory CampaignApiResponse.fromJson(Map<String, dynamic> json) =>
      CampaignApiResponse(
        items: List<Campaign>.from(
            json["_items"].map((x) => Campaign.fromJson(x))),
        links: CampaignApiResponseLinks.fromJson(json["_links"]),
        meta: Meta.fromJson(json["_meta"]),
      );

  Map<String, dynamic> toJson() => {
        "_items": List<dynamic>.from(items.map((x) => x.toJson())),
        "_links": links.toJson(),
        "_meta": meta.toJson(),
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

  Title title;
  String href;

  factory Last.fromJson(Map<String, dynamic> json) => Last(
        title: json["title"] == null ? null : titleValues.map[json["title"]],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : titleValues.reverse[title],
        "href": href,
      };
}

enum Title { CAMPAIGNS_LISTS, LAST_PAGE, NEXT_PAGE, HOME, CAMPAIGNS }

final titleValues = EnumValues({
  "campaigns": Title.CAMPAIGNS,
  "campaigns Lists": Title.CAMPAIGNS_LISTS,
  "home": Title.HOME,
  "last page": Title.LAST_PAGE,
  "next page": Title.NEXT_PAGE
});

class CampaignApiResponseLinks {
  CampaignApiResponseLinks({
    this.parent,
    this.self,
    this.next,
    this.last,
  });

  Last parent;
  Last self;
  Last next;
  Last last;

  factory CampaignApiResponseLinks.fromJson(Map<String, dynamic> json) =>
      CampaignApiResponseLinks(
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
