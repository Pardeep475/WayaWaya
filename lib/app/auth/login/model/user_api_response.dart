import 'dart:convert';

import 'package:wayawaya/app/auth/login/model/user_data_response.dart';

UserApiResponse userApiResponseFromJson(String str) =>
    UserApiResponse.fromJson(json.decode(str));

String userApiResponseToJson(UserApiResponse data) =>
    json.encode(data.toJson());

class UserApiResponse {
  UserApiResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  UserDataResponse data;

  factory UserApiResponse.fromJson(Map<String, dynamic> json) =>
      UserApiResponse(
        status: json["status"],
        message: json["message"],
        data: UserDataResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}
