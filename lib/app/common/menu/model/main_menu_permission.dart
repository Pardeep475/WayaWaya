import 'dart:convert';

MainMenuPermission mainMenuPermissionFromJson(String str) =>
    MainMenuPermission.fromJson(json.decode(str));

String mainMenuPermissionToJson(MainMenuPermission data) =>
    json.encode(data.toJson());

class MainMenuPermission {
  MainMenuPermission({
    this.id,
    this.venueProfileId,
    this.unregisteredTemplate,
    this.displayName,
    this.icon,
    this.color,
    this.activity,
    this.usageOverlayTemplate,
    this.regMode,
    this.unregMode,
    this.sequenceNumber,
  });

  int id;
  String venueProfileId;
  List<DisplayName> unregisteredTemplate;
  List<DisplayName> displayName;
  IconModel icon;
  String color;
  String activity;
  List<DisplayName> usageOverlayTemplate;
  String regMode;
  String unregMode;
  int sequenceNumber;

  factory MainMenuPermission.fromJson(Map<String, dynamic> json) =>
      MainMenuPermission(
        id: json["id"],
        venueProfileId: json["venue_profile_id"],
        unregisteredTemplate: json["unregistered_template"] == null
            ? null
            : List<DisplayName>.from(
                jsonDecode(json["unregistered_template"]).map(
                  (x) => DisplayName.fromJson(x),
                ),
              ),
        displayName: List<DisplayName>.from(
          jsonDecode(json["display_name"]).map(
            (x) => DisplayName.fromJson(x),
          ),
        ),
        icon: IconModel.fromJson(jsonDecode(json["icon"])),
        color: json["color"],
        activity: json["activity"],
        usageOverlayTemplate: List<DisplayName>.from(
          jsonDecode(json["usage_overlay_template"]).map(
            (x) => DisplayName.fromJson(x),
          ),
        ),
        regMode: json["reg_mode"],
        unregMode: json["unreg_mode"],
        sequenceNumber: json["sequence_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "venue_profile_id": venueProfileId,
        "unregistered_template": unregisteredTemplate == null
            ? null
            : List<dynamic>.from(unregisteredTemplate.map((x) => x.toJson())),
        "display_name": List<dynamic>.from(displayName.map((x) => x.toJson())),
        "icon": icon.toJson(),
        "color": color,
        "activity": activity,
        "usage_overlay_template":
            List<dynamic>.from(usageOverlayTemplate.map((x) => x.toJson())),
        "reg_mode": regMode,
        "unreg_mode": unregMode,
        "sequence_number": sequenceNumber,
      };
}

class DisplayName {
  DisplayName({
    this.text,
    this.language,
  });

  String text;
  String language;

  factory DisplayName.fromJson(Map<String, dynamic> json) => DisplayName(
        text: json["text"] == null ? "" : json["text"],
        language: json["language"] == null ? "" : json["language"],
      );

  Map<String, dynamic> toJson() => {
        "text": text ?? "",
        "language": language ?? "",
      };
}

class IconModel {
  IconModel({
    this.type,
    this.name,
  });

  String type;
  String name;

  factory IconModel.fromJson(Map<String, dynamic> json) => IconModel(
        type: json["type"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
      };
}
