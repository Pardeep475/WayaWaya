import 'dart:convert';

Map<String, dynamic> userModelToJson(UserModel data) => /*json.encode(*/ data
    .toJson() /*)*/;

class UserModel {
  String username;
  String password;

  UserModel({
    this.username = '',
    this.password = '',
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
