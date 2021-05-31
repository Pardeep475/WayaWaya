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
    type: json["type"] == null ? '' : json["type"],
    value: json["value"] == null ? '' : json["value"],
    mode: json["mode"] == null ? '' : json["mode"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? '' : type,
    "value": value == null ? '' : value,
    "mode": mode == null ? '' : mode,
  };
}