class CymkCode {
  double c;
  double y;
  double m;
  double k;

  CymkCode({this.c, this.y, this.m, this.k});

  Map<String, dynamic> toJson() => {"c": c, "y": y, "m": m, "k": k};

  CymkCode.fromJson(Map<String, dynamic> json) {
    c = json['c'];
    y = json['y'];
    m = json['m'];
    k = json['k'];
  }
}
