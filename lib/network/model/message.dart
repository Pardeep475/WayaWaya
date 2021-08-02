import 'dart:convert';

import 'package:wayawaya/common/model/language_store.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  final List<LanguageStore> title;
  final List<LanguageStore> body;
  final bool html;

  Message({this.title, this.body, this.html});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        title: json["title"] == null
            ? null
            : List<LanguageStore>.from(
                jsonDecode(json["title"]).map(
                  (x) => LanguageStore.fromJson(x),
                ),
              ),
        body: json["description"] == null
            ? null
            : List<LanguageStore>.from(
                jsonDecode(json["description"]).map(
                  (x) => LanguageStore.fromJson(x),
                ),
              ),
        html: json["html"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : jsonEncode(title),
        "body": body == null ? null : jsonEncode(body),
        "html": html,
      };
}
