import 'dart:convert';

Web webFromJson(String str) =>
    Web.fromJson(json.decode(str));

String webToJson(Web data) => json.encode(data.toJson());

class Web{
  final String text;
  final bool link;

  Web({this.text, this.link});


  factory Web.fromJson(Map<String, dynamic> json) => Web(
    text: json["text"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "link": link,
  };

}