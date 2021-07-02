import 'dart:convert';

OmniChannelItemModel polygonModelFromJson(String str) =>
    OmniChannelItemModel.fromJson(json.decode(str));

String polygonModelToJson(OmniChannelItemModel data) =>
    json.encode(data.toJson());

class OmniChannelItemModel {
  String id;
  String oid;
  String status;
  int messageLimit;
  String description;
  dynamic presence;
  String costCenterCode;
  int nuisanceLimit;
  String nuisancePeriod;
  String zoneTag;
  String triggerZoneId;
  String subType;
  dynamic nuisenceRule;
  String analyticTag;
  String coolDownPeriod;
  String type;
  String guardTimeStart;
  String theme;
  String downloadUrl;
  String analyticsTriggers;
  String url1;
  String url2;
  String imageSizeId;
  int coolDownTime;
  String guardTimeStop;

  OmniChannelItemModel(
      {this.id,
      this.oid,
      this.status,
      this.messageLimit,
      this.description,
      this.presence,
      this.costCenterCode,
      this.nuisanceLimit,
      this.nuisancePeriod,
      this.zoneTag,
      this.triggerZoneId,
      this.subType,
      this.nuisenceRule,
      this.analyticTag,
      this.coolDownPeriod,
      this.type,
      this.guardTimeStart,
      this.theme,
      this.downloadUrl,
      this.analyticsTriggers,
      this.url1,
      this.url2,
      this.imageSizeId,
      this.coolDownTime,
      this.guardTimeStop});

  factory OmniChannelItemModel.fromJson(Map<String, dynamic> json) =>
      OmniChannelItemModel(
        id: json["_id"],
        oid: json["oid"],
        status: json["status"],
        messageLimit: json["message_limit"],
        description: json["description"],
        presence: json["presence"],
        costCenterCode: json["cost_center_code"],
        nuisanceLimit: json["nuisance_limit"],
        nuisancePeriod: json["nuisance_period"],
        zoneTag: json["zone_tag"],
        triggerZoneId: json["trigger_zone_id"],
        subType: json["sub_type"],
        nuisenceRule: json["nuisence_rule"],
        analyticTag: json["analytic_tag"],
        coolDownPeriod: json["cool_down_period"],
        type: json["type"],
        guardTimeStart: json["guard_time_start"],
        theme: json["theme"],
        downloadUrl: json["download_url"],
        analyticsTriggers: json["analytics_triggers"],
        url1: json["url1"],
        url2: json["url2"],
        imageSizeId: json["image_size_id"],
        coolDownTime: json["cool_down_time"],
        guardTimeStop: json["guard_time_stop"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "oid": oid,
        "status": status,
        "message_limit": messageLimit,
        "description": description,
        "presence": presence,
        "cost_center_code": costCenterCode,
        "nuisance_limit": nuisanceLimit,
        "nuisance_period": nuisancePeriod,
        "zone_tag": zoneTag,
        "trigger_zone_id": triggerZoneId,
        "sub_type": subType,
        "nuisence_rule": nuisenceRule,
        "analytic_tag": analyticTag,
        "cool_down_period": coolDownPeriod,
        "type": type,
        "guard_time_start": guardTimeStart,
        "theme": theme,
        "download_url": downloadUrl,
        "analytics_triggers": analyticsTriggers,
        "url1": url1,
        "url2": url2,
        "image_size_id": imageSizeId,
        "cool_down_time": coolDownTime,
        "guard_time_stop": guardTimeStop
      };
}
