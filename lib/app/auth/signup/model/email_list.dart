Map<String, dynamic> emailListModelToJson(EmailList data) =>
    /*json.encode(*/ data.toJson() /*)*/;

class EmailList {
  String type;
  String mode;
  String value;

  EmailList({this.type, this.mode, this.value});

  Map<String, dynamic> toJson() => {
        "type": type,
        "mode": mode,
        "value": value,
      };
}
