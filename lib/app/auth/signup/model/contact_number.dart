import 'dart:convert';

// Map<String, dynamic> contactNumberModelToJson(ContactNumber data) =>
//     /*json.encode(*/ data.toJson() /*)*/;

ContactNumber contactNumberFromJson(String str) =>
    ContactNumber.fromJson(json.decode(str));

String contactNumberToJson(ContactNumber data) =>
    json.encode(data.toJson());

class ContactNumber{
  String type;
  String data;

  ContactNumber({this.type, this.data});

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": data,
  };

  ContactNumber.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'];
  }


}