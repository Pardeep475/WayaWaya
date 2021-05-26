class Preferences {
  Preferences({
    this.favoriteMalls,
    this.categories,
    this.defaultLanguage,
    this.notification,
    this.alternateCurrency,
  });

  String favoriteMalls;
  List<String> categories;
  String defaultLanguage;
  int notification;
  String alternateCurrency;

  factory Preferences.fromJson(Map<String, dynamic> json) => Preferences(
        favoriteMalls:
            json["favorite_malls"] == null ? null : json["favorite_malls"],
        categories: json["categories"] == null
            ? null
            : List<String>.from(json["categories"].map((x) => x)),
        defaultLanguage:
            json["default_language"] == null ? null : json["default_language"],
        notification:
            json["notification"] == null ? null : json["notification"],
        alternateCurrency: json["alternate_currency"] == null
            ? null
            : json["alternate_currency"],
      );

  Map<String, dynamic> toJson() => {
        "favorite_malls": favoriteMalls == null ? null : favoriteMalls,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x)),
        "default_language": defaultLanguage == null ? null : defaultLanguage,
        "notification": notification == null ? null : notification,
        "alternate_currency":
            alternateCurrency == null ? null : alternateCurrency,
      };
}
