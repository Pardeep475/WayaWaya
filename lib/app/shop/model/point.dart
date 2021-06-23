import 'dart:convert';

Point pointFromJson(String str) => Point.fromJson(json.decode(str));

String pointToJson(Point data) => json.encode(data.toJson());

class Point {
  final String type;
  final List<dynamic> coordinates;

  Point({this.type, this.coordinates});

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? null
            : List<dynamic>.from(
                json["coordinates"].map(
                  (x) => x,
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(
                coordinates.map((x) => x),
              ),
      };
}
