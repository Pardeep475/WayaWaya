class LanguageStore {
  String language;
  String text;

  Map<String, dynamic> toJson() => {
        "language": language,
        "text": text,
      };

  LanguageStore.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    text = json['text'];
  }
}
