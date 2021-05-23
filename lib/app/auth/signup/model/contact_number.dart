Map<String, dynamic> contactNumberModelToJson(ContactNumber data) =>
    /*json.encode(*/ data.toJson() /*)*/;

class ContactNumber{
  String type;
  String data;

  ContactNumber({this.type, this.data});

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": data,
  };
}