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
    token: json["token"] == null ? '' : json["token"],
    socialId: json["social_id"] == null ? '' : json["social_id"],
    type: json["type"] == null ? '' : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? '' : token,
    "social_id": socialId == null ? '' : socialId,
    "type": type == null ? '' : type,
  };
}