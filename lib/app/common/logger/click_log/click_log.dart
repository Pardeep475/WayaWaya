import 'dart:convert';

import 'device_details.dart';

ClickLog clickLogFromJson(String str) => ClickLog.fromJson(json.decode(str));

String clickLogToJson(ClickLog data) => json.encode(data.toJson());

class ClickLog {
   String uuid;
   String type;
   DeviceDetails device;
   String appVersion;
   String group;
   String action;
   String data;
   bool production;

  ClickLog(
      {this.uuid,
      this.type,
      this.device,
      this.appVersion,
      this.group,
      this.action,
      this.data,
      this.production});

  factory ClickLog.fromJson(Map<String, dynamic> json) => ClickLog(
        uuid: json["uuid"],
        type: json["type"],
        device: json["device"],
        appVersion: json["app_version"],
        group: json["group"],
        action: json["action"],
        data: json["data"],
        production: json["production"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "type": type,
        "device": device,
        "app_version": appVersion,
        "group": group,
        "action": action,
        "data": data,
        "production": production,
      };
}
