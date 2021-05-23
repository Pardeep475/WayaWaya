Map<String, dynamic> socialMediaModelToJson(SocialMedia data) =>
    /*json.encode(*/ data.toJson() /*)*/;

class SocialMedia {
  String type;

  String social_id;

  String token;

  SocialMedia({this.type, this.social_id, this.token});

  Map<String, dynamic> toJson() => {
        "type": type,
        "social_id": social_id,
        "token": token,
      };
}
