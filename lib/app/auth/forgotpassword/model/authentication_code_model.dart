Map<String, dynamic> authenticationCodeModelToJson(
    AuthenticationCodeModel data) => /*json.encode(*/ data.toJson() /*)*/;

class AuthenticationCodeModel {
  String code;
  String user_name;
  String password;

  AuthenticationCodeModel({this.code, this.user_name, this.password});

  Map<String, dynamic> toJson() => {
        "code": code,
        "user_name": user_name,
        "password": password,
      };
}
