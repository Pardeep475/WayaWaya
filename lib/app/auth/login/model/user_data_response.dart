import 'dart:convert';

import 'package:wayawaya/app/auth/signup/model/contact_number.dart';
import 'package:wayawaya/app/auth/signup/model/loyalty_status.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/utils.dart';

UserDataResponse userDataResponseFromJson(String str) =>
    UserDataResponse.fromJson(json.decode(str));

String userDataResponseToJson(UserDataResponse data) =>
    json.encode(data.toJson());

class UserDataResponse {
  String firstName;
  String lastName;
  String dob;
  String username;
  String email;
  String accessToken;
  bool isLogin;
  String loginType;
  String userId;
  String cellnumber;
  String clientApi;
  String categories;
  String favouriteMall;
  String currency;
  String language;
  String devices;
  String loyaltyStatus;
  String gender;
  String registrationDate;
  bool isTester;
  String notification;

  UserDataResponse(
      {this.firstName,
      this.lastName,
      this.dob,
      this.username,
      this.email,
      this.accessToken,
      this.isLogin,
      this.loginType,
      this.userId,
      this.cellnumber,
      this.clientApi,
      this.categories,
      this.favouriteMall,
      this.currency,
      this.language,
      this.devices,
      this.loyaltyStatus,
      this.gender,
      this.registrationDate,
      this.notification,
      this.isTester});

  UserDataResponse.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    dob = json['dob'] != null ? json['dob'].toString() : null;
    username = json['username'];
    email = json['email'];
    accessToken = json['accessToken'];
    isLogin = json['isLogin'];
    loginType = json['loginType'];
    userId = json['userId'];
    cellnumber = json['cellnumber'];
    clientApi = json['clientApi'];
    categories = json['categories'];
    favouriteMall = json['favouriteMall'];
    currency = json['currency'];
    language = json['language'];
    devices = json['devices'];
    loyaltyStatus = json['loyaltyStatus'];
    gender = json['gender'];
    registrationDate = json['registrationDate'];
    isTester = json['isTester'];
    notification = json['notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['dob'] = this.dob;
    data['username'] = this.username;
    data['email'] = this.email;
    data['accessToken'] = this.accessToken;
    data['isLogin'] = this.isLogin;
    data['loginType'] = this.loginType;
    data['userId'] = this.userId;
    data['cellnumber'] = this.cellnumber;
    data['clientApi'] = this.clientApi;
    data['categories'] = this.categories;
    data['favouriteMall'] = this.favouriteMall;
    data['currency'] = this.currency;
    data['language'] = this.language;
    data['devices'] = this.devices;
    data['loyaltyStatus'] = this.loyaltyStatus;
    data['gender'] = this.gender;
    data['registrationDate'] = this.registrationDate;
    data['isTester'] = this.isTester;
    data['notification'] = this.notification;
    return data;
  }
}
