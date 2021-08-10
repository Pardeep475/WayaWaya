class GeoLocation {
  GeoLocation({
    this.message,
    this.radius,
    this.location,
  });

  Message message;
  int radius;
  Location location;

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
        radius: json["radius"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message.toJson(),
        "radius": radius,
        "location": location == null ? null : location.toJson(),
      };
}

class Location {
  Location({
    this.coordinates,
    this.type,
  });

  List<double> coordinates;
  String type;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}

class Message {
  Message({
    this.title,
    this.body,
  });

  String title;
  String body;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
      };
}
