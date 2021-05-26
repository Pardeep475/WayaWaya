class SocialMedia {
  SocialMedia({
    this.token,
    this.socialId,
    this.type,
  });

  String token;
  String socialId;
  String type;

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
    token: json["token"] == null ? null : json["token"],
    socialId: json["social_id"] == null ? null : json["social_id"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "social_id": socialId == null ? null : socialId,
    "type": type == null ? null : type,
  };
}