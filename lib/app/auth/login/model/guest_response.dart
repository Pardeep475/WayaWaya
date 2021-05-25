import 'dart:convert';

GuestResponse guestResponseFromJson(String str) =>
    GuestResponse.fromJson(json.decode(str));

String guestResponseToJson(GuestResponse data) => json.encode(data.toJson());

class GuestResponse {
  GuestResponse({
    this.accessToken,
    this.refreshToken,
    this.expiry,
  });

  String accessToken;
  String refreshToken;
  String expiry;

  factory GuestResponse.fromJson(Map<String, dynamic> json) => GuestResponse(
        accessToken: json["access_token"] == null ? null : json["access_token"],
        refreshToken:
            json["refresh_token"] == null ? null : json["refresh_token"],
        expiry: json["expiry"] == null ? null : json["expiry"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken == null ? null : accessToken,
        "refresh_token": refreshToken == null ? null : refreshToken,
        "expiry": expiry == null ? null : expiry,
      };
}
