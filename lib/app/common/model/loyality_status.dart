class LoyaltyStatus {
  LoyaltyStatus({
    this.points,
    this.level,
    // this.label,
  });

  int points;
  int level;
  // List<Label> label;

  factory LoyaltyStatus.fromJson(Map<String, dynamic> json) => LoyaltyStatus(
    points: json["points"] == null ? null : json["points"],
    level: json["level"] == null ? null : json["level"],
    // label: json["label"] == null ? null : List<Label>.from(json["label"].map((x) => Label.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "points": points == null ? null : points,
    "level": level == null ? null : level,
    // "label": label == null ? null : List<dynamic>.from(label.map((x) => x.toJson())),
  };
}