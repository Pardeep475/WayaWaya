import 'dart:convert';

ResourceData resourceDataFromJson(String str) =>
    ResourceData.fromJson(json.decode(str));

String resourceDataToJson(ResourceData data) => json.encode(data.toJson());

class ResourceData {
  final String foreground;
  final String background;

  ResourceData({this.foreground, this.background});

  factory ResourceData.fromJson(Map<String, dynamic> json) => ResourceData(
        foreground: json["foreground"],
        background: json["background"],
      );

  Map<String, dynamic> toJson() => {
        "foreground": foreground,
        "background": background,
      };
}
