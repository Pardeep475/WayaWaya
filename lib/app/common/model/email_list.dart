class EmailList {
  EmailList({
    this.type,
    this.value,
    this.mode,
  });

  String type;
  String value;
  String mode;

  factory EmailList.fromJson(Map<String, dynamic> json) => EmailList(
    type: json["type"] == null ? null : json["type"],
    value: json["value"] == null ? null : json["value"],
    mode: json["mode"] == null ? null : json["mode"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "value": value == null ? null : value,
    "mode": mode == null ? null : mode,
  };
}