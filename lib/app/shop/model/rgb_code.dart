class RgbCode {
  int r;
  int g;
  int b;

  Map<String, dynamic> toJson() => {"r": r, "g": g, "b": b};

  RgbCode.fromJson(Map<String, dynamic> json) {
    r = json['r'];
    b = json['b'];
    g = json['g'];
  }
}