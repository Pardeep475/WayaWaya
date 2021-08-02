import 'dart:convert';

Icon iconFromJson(String str) =>
    Icon.fromJson(json.decode(str));

String iconToJson(Icon data) => json.encode(data.toJson());


class Icon{
  final String name;
  final String type;


  Icon({this.name, this.type});

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "name": name,
  };
}