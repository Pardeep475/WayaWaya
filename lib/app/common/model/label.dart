class Label {
  Label({
    this.text,
    this.language,
  });

  String text;
  String language;

  factory Label.fromJson(Map<String, dynamic> json) => Label(
    text: json["text"] == null ? null : json["text"],
    language: json["language"] == null ? null : json["language"],
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "language": language == null ? null : language,
  };
}