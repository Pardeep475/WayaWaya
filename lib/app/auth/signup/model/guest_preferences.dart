Map<String, dynamic> guestPreferencesModelToJson(GuestPreferences data) =>
    /*json.encode(*/ data.toJson() /*)*/;

class GuestPreferences {
  String default_language;
  String alternate_currency;
  String favorite_malls;
  int notification;
  List<String> categories;

  GuestPreferences(
      {this.default_language,
      this.alternate_currency,
      this.favorite_malls,
      this.notification,
      this.categories});

  Map<String, dynamic> toJson() => {
        "default_language": default_language,
        "alternate_currency": alternate_currency,
        "favorite_malls": favorite_malls,
        "notification": notification,
        "categories": notification != null ? categories.toString() : null,
      };
}
