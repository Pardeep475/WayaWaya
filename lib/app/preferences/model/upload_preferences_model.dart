// import 'dart:convert';
//
// UploadPreferencesModel uploadPreferencesModelFromJson(String str) =>
//     UploadPreferencesModel.fromJson(json.decode(str));
//
// String uploadPreferencesModelToJson(UploadPreferencesModel data) =>
//     json.encode(data.toJson());
//
// class UploadPreferencesModel {
//   UploadPreferencesModel({
//     this.categories,
//     this.notification,
//     this.favoriteMalls,
//     this.alternateCurrency,
//     this.defaultLanguage,
//   });
//
//   List<String> categories;
//   int notification;
//   String favoriteMalls;
//   String alternateCurrency;
//   String defaultLanguage;
//
//   factory UploadPreferencesModel.fromJson(Map<String, dynamic> json) =>
//       UploadPreferencesModel(
//         categories: json["categories"] == null
//             ? null
//             : List<String>.from(json["categories"].map((x) => x)),
//         notification: json["notification"],
//         favoriteMalls: json["favorite_malls"],
//         alternateCurrency: json["alternate_currency"],
//         defaultLanguage: json["default_language"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "categories": categories == null
//             ? null
//             : List<dynamic>.from(categories.map((x) => x)),
//         "notification": notification,
//         "favorite_malls": favoriteMalls,
//         "alternate_currency": alternateCurrency,
//         "default_language": defaultLanguage,
//       };
// }
//
//
// // To parse this JSON data, do
// //
// //     final uploadPreferencesModel = uploadPreferencesModelFromJson(jsonString);

import 'dart:convert';

UploadPreferencesModel uploadPreferencesModelFromJson(String str) => UploadPreferencesModel.fromJson(json.decode(str));

String uploadPreferencesModelToJson(UploadPreferencesModel data) => json.encode(data.toJson());

class UploadPreferencesModel {
  UploadPreferencesModel({
    this.preferences,
  });

  UploadPreferencesModelData preferences;

  factory UploadPreferencesModel.fromJson(Map<String, dynamic> json) => UploadPreferencesModel(
    preferences: UploadPreferencesModelData.fromJson(json["preferences"]),
  );

  Map<String, dynamic> toJson() => {
    "preferences": preferences.toJson(),
  };
}

class UploadPreferencesModelData {
  UploadPreferencesModelData({
    this.categories,
    this.notification,
    this.favoriteMalls,
    this.alternateCurrency,
    this.defaultLanguage,
  });

  List<String> categories;
  int notification;
  String favoriteMalls;
  String alternateCurrency;
  String defaultLanguage;

  factory UploadPreferencesModelData.fromJson(Map<String, dynamic> json) => UploadPreferencesModelData(
    categories: List<String>.from(json["categories"].map((x) => x)),
    notification: json["notification"],
    favoriteMalls: json["favorite_malls"],
    alternateCurrency: json["alternate_currency"],
    defaultLanguage: json["default_language"],
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "notification": notification,
    "favorite_malls": favoriteMalls,
    "alternate_currency": alternateCurrency,
    "default_language": defaultLanguage,
  };
}

