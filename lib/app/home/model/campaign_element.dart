// To parse this JSON data, do
//
//     final campaignElement = campaignElementFromJson(jsonString);

import 'dart:convert';

import 'package:wayawaya/common/model/language_store.dart';

CampaignElement campaignElementFromJson(String str) =>
    CampaignElement.fromJson(json.decode(str));

String campaignElementToJson(CampaignElement data) =>
    json.encode(data.toJson());

class CampaignElement {
  CampaignElement({
    this.description,
    this.name,
    this.format,
    this.url,
    this.text,
    this.order,
    this.imageId,
    this.urlLinkAlias,
    this.type,
    this.templateId,
    // this.campaignTemplate,
    // this.coolOffPeriod,
    this.locationFieldTag,
  });

  // List<LanguageStore> description;
  // List<LanguageStore> name;
  // List<Description> format;
  // List<Description> url;
  // List<Description> text;
  dynamic description;
  dynamic name;
  dynamic format;
  dynamic url;
  dynamic text;
  int order;
  // List<ImageId> imageId;
  // List<Description> urlLinkAlias;
  dynamic imageId;
  dynamic urlLinkAlias;
  String type;
  String templateId;
  // CampaignTemplate campaignTemplate;
  // int coolOffPeriod;
  String locationFieldTag;

  factory CampaignElement.fromJson(Map<String, dynamic> json) =>
      CampaignElement(
        // description: json["description"] == null ? [] : List<LanguageStore>.from(
        //     json["description"].map((x) => LanguageStore.fromJson(x))),
        description: json["description"],
        name:  json["name"] ,
        format: json["format"],
        url: json["url"],
        text:json["text"] ,
        order: json["order"],
        imageId:json["image_id"],
        urlLinkAlias: json["url_link_alias"],
        type: json["type"],
        templateId: json["template_id"],
        // campaignTemplate: json["campaign_template"] == null
        //     ? null
        //     : CampaignTemplate.fromJson(json["campaign_template"]),
        // coolOffPeriod: json["cool_off_period"],
        locationFieldTag: json["location_field_tag"],
      );

  Map<String, dynamic> toJson() => {
        "description": description == null ? null : jsonEncode(description),
        "name": name == null ? null :  jsonEncode(name),
        "format": format == null ? null : jsonEncode(format),
        "url": url == null ? null :  jsonEncode(url),
        "text": text == null ? null :  jsonEncode(text),
        "order": order,
        "image_id": imageId == null ? null :  jsonEncode(imageId),
        "url_link_alias": urlLinkAlias == null ? null : jsonEncode(urlLinkAlias),
        "type": type,
        "template_id": templateId,
        // "campaign_template":
        //     campaignTemplate == null ? null : campaignTemplate.toJson(),
        // "cool_off_period": coolOffPeriod,
        "location_field_tag": locationFieldTag,
      };
}

class CampaignTemplate {
  CampaignTemplate({
    this.status,
    this.userId,
    this.type,
    this.name,
    this.comments,
  });

  String status;
  String userId;
  String type;
  String name;
  String comments;

  factory CampaignTemplate.fromJson(Map<String, dynamic> json) =>
      CampaignTemplate(
        status: json["status"],
        userId: json["user_id"],
        type: json["type"],
        name: json["name"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user_id": userId,
        "type": type,
        "name": name,
        "comments": comments,
      };
}

class Description {
  Description({
    this.text,
    this.language,
  });

  String text;
  Language language;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        text: json["text"],
        language: languageValues.map[json["language"]],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "language": languageValues.reverse[language],
      };
}

enum Language { EN_US, FR }

final languageValues = EnumValues({"en_US": Language.EN_US, "fr": Language.FR});

class ImageId {
  ImageId({
    this.text,
    this.language,
    this.type,
  });

  String text;
  Language language;
  String type;

  factory ImageId.fromJson(Map<String, dynamic> json) => ImageId(
        text: json["text"],
        language: languageValues.map[json["language"]],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "language": languageValues.reverse[language],
        "type": type,
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
