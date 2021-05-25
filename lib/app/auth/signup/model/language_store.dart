// Map<String, dynamic> languageStoreModelToJson(LanguageStore data) =>
//     /*json.encode(*/ data.toJson() /*)*/;

import 'dart:convert';

LanguageStore languageStoreFromJson(String str) =>
    LanguageStore.fromJson(json.decode(str));

String languageStoreToJson(LanguageStore data) =>
    json.encode(data.toJson());

class LanguageStore{
  String language;
  String text;

  LanguageStore({this.language, this.text});

  Map<String, dynamic> toJson() => {
    "language": language,
    "text": text,
  };

  LanguageStore.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    text = json['text'];
  }
}