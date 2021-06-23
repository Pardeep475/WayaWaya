import 'dart:convert';

PolygonModel polygonModelFromJson(String str) =>
    PolygonModel.fromJson(json.decode(str));

String polygonModelToJson(PolygonModel data) => json.encode(data.toJson());

class PolygonModel {
  final String type;

  PolygonModel({this.type});

  factory PolygonModel.fromJson(Map<String, dynamic> json) => PolygonModel(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}
