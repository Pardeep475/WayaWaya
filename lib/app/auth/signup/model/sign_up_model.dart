import 'dart:convert';

import 'package:wayawaya/app/common/model/contact_number.dart';
import 'package:wayawaya/app/common/model/email_list.dart';
import 'package:wayawaya/app/common/model/guest_preference.dart';
import 'package:wayawaya/app/common/model/loyality_status.dart';
import 'package:wayawaya/app/common/model/social_media.dart';


SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) =>
    json.encode(data.toJson());


class SignUpModel {
  SocialMedia socialMedia;
  String password;
  String userName;
  String timeZone;
  String lastName;
  String lastLogin;
  String firstName;
  String title;
  String registrationDate;
  String dateOfBirth;
  bool agreeNewsletter;
  bool agreeNotifications;
  bool agreeTnc;
  bool testerFlag;
  String id;
  EmailList emailList;
  List<CellNumberList> cellNumberList;
  List<String> devices;
  LoyaltyStatus loyaltyStatus;
  Preferences preferences;

  SignUpModel(
      {this.socialMedia,
      this.password,
      this.userName,
      this.timeZone,
      this.lastName,
      this.lastLogin,
      this.firstName,
      this.title,
      this.registrationDate,
      this.dateOfBirth,
      this.agreeNewsletter,
      this.agreeNotifications,
      this.agreeTnc,
      this.testerFlag,
      this.id,
      this.emailList,
      this.cellNumberList,
      this.devices,
      this.loyaltyStatus,
      this.preferences});


  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    socialMedia: json["social_media"] == null ? null : SocialMedia.fromJson(json["social_media"]),
    password: json["password"] == null ? null : json["password"],
    userName: json["user_name"] == null ? null : json["user_name"],
    timeZone: json["time_zone"] == null ? null : json["time_zone"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    lastLogin: json["last_login"] == null ? null : json["last_login"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    title: json["title"] == null ? null : json["title"],
    registrationDate: json["registration_date"] == null ? null : json["registration_date"],
    dateOfBirth: json["date_of_birth"] == null ? null : json["date_of_birth"],
    agreeNewsletter: json["agree_newsletter"] == null ? null : json["agree_newsletter"],
    agreeNotifications: json["agree_notifications"] == null ? null : json["agree_notifications"],
    agreeTnc: json["agree_tnc"] == null ? null : json["agree_tnc"],
    testerFlag: json["tester_flag"] == null ? null : json["tester_flag"],
    id: json["_id"] == null ? null : json["_id"],
    emailList: json["email_list"] == null ? null : EmailList.fromJson(json["email_list"]),
    cellNumberList: json["cell_number_list"] == null ? null : List<CellNumberList>.from(json["cell_number_list"].map((x) => CellNumberList.fromJson(x))),
    devices: json["devices"] == null ? null : List<String>.from(json["devices"].map((x) => x)),
    loyaltyStatus: json["loyalty_status"] == null ? null : LoyaltyStatus.fromJson(json["loyalty_status"]),
    preferences: json["preferences"] == null ? null : Preferences.fromJson(json["preferences"]),
  );

  Map<String, dynamic> toJson() => {
    "social_media": socialMedia == null ? null : socialMedia.toJson(),
    "password": password == null ? null : password,
    "user_name": userName == null ? null : userName,
    "time_zone": timeZone == null ? null : timeZone,
    "last_name": lastName == null ? null : lastName,
    "last_login": lastLogin == null ? null : lastLogin,
    "first_name": firstName == null ? null : firstName,
    "title": title == null ? null : title,
    "registration_date": registrationDate == null ? null : registrationDate,
    "date_of_birth": dateOfBirth == null ? null : dateOfBirth,
    "agree_newsletter": agreeNewsletter == null ? null : agreeNewsletter,
    "agree_notifications": agreeNotifications == null ? null : agreeNotifications,
    "agree_tnc": agreeTnc == null ? null : agreeTnc,
    "tester_flag": testerFlag == null ? null : testerFlag,
    "_id": id == null ? null : id,
    "email_list": emailList == null ? null : emailList.toJson(),
    "cell_number_list": cellNumberList == null ? null : List<dynamic>.from(cellNumberList.map((x) => x.toJson())),
    "devices": devices == null ? null : List<dynamic>.from(devices.map((x) => x)),
    "loyalty_status": loyaltyStatus == null ? null : loyaltyStatus.toJson(),
    "preferences": preferences == null ? null : preferences.toJson(),
  };

}
