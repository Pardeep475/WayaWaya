Map<String, dynamic> languageStoreModelToJson(LanguageStore data) =>
    /*json.encode(*/ data.toJson() /*)*/;

class LanguageStore{
  String language;
  String text;

  LanguageStore({this.language, this.text});

  Map<String, dynamic> toJson() => {
    "language": language,
    "text": text,
  };
}