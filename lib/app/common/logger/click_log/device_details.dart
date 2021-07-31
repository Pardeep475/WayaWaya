import 'dart:convert';

DeviceDetails deviceDetailsFromJson(String str) =>
    DeviceDetails.fromJson(json.decode(str));

String deviceDetailsToJson(DeviceDetails data) => json.encode(data.toJson());

class DeviceDetails {
  String platform;
  String system_version;
  String device_name;
  String id;

  DeviceDetails(
      {this.platform, this.system_version, this.device_name, this.id});

  factory DeviceDetails.fromJson(Map<String, dynamic> json) => DeviceDetails(
        platform: json["platform"],
        system_version: json["system_version"],
        device_name: json["device_name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "platform": platform,
        "system_version": system_version,
        "device_name": device_name,
        "id": id,
      };
}
