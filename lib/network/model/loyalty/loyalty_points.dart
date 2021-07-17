class LoyaltyPoints {
  int redeemed;
  int totalPointsEarned;
  int availablePoints;

  LoyaltyPoints({this.redeemed, this.totalPointsEarned, this.availablePoints});

  factory LoyaltyPoints.fromJson(Map<String, dynamic> json) => LoyaltyPoints(
        redeemed: json["redeemed"],
        totalPointsEarned: json["total_points_earned"],
        availablePoints: json["available_points"],
      );

  Map<String, dynamic> toJson() => {
        "redeemed": redeemed,
        "total_points_earned": totalPointsEarned,
        "available_points": availablePoints,
      };
}
