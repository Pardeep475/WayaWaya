class MallProfileModel {
  String name;
  String label;
  String identifier;
  String key;
  String geo_location;
  String db_name;
  String logo_base64;
  String ibeacon_uuid;
  String venue_data;
  int active;

  MallProfileModel(
      {this.name,
      this.label,
      this.identifier,
      this.key,
      this.geo_location,
      this.db_name,
      this.logo_base64,
      this.ibeacon_uuid,
      this.venue_data,
      this.active});

  Map<String, dynamic> toJson() => {
        "name": name,
        "label": label,
        "identifier": identifier,
        "key": key,
        "geo_location": geo_location,
        "db_name": db_name,
        "logo_base64": logo_base64,
        "ibeacon_uuid": ibeacon_uuid,
        "venue_data": venue_data,
        "active": active,
      };

  MallProfileModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    geo_location = json['geo_location'];
    identifier = json['identifier'];
    label = json['label'];
    name = json['name'];
    db_name = json['db_name'];
    logo_base64 = json['logo_base64'];
    ibeacon_uuid = json['ibeacon_uuid'];
    venue_data = json['venue_data'];
    active = json['active'];
  }
}
