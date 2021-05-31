import 'dart:convert';

import 'package:wayawaya/app/common/model/contact_number.dart';
import 'package:wayawaya/app/common/model/email_list.dart';
import 'package:wayawaya/app/common/model/guest_preference.dart';
import 'package:wayawaya/app/common/model/loyality_status.dart';
import 'package:wayawaya/app/common/model/social_media.dart';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SocialMedia socialMedia;
  String password;
  String userName;
  String timeZone;
  String lastName;
  String firstName;
  String title;
  String registrationDate;
  String dateOfBirth;
  bool agreeNewsletter;
  bool agreeNotifications;
  bool agreeTnc;
  bool testerFlag;
  EmailList emailList;
  List<CellNumberList> cellNumberList;
  List<String> devices;
  Preferences preferences;

  SignUpModel(
      {this.socialMedia,
      this.password,
      this.userName,
      this.timeZone,
      this.lastName,
      this.firstName,
      this.title,
      this.registrationDate,
      this.dateOfBirth,
      this.agreeNewsletter,
      this.agreeNotifications,
      this.agreeTnc,
      this.testerFlag,
      this.emailList,
      this.cellNumberList,
      this.devices,
      this.preferences});

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        socialMedia: json["social_media"] == null
            ? SocialMedia()
            : SocialMedia.fromJson(json["social_media"]),
        password: json["password"] == null ? '' : json["password"],
        userName: json["user_name"] == null ? '' : json["user_name"],
        timeZone: json["time_zone"] == null ? '' : json["time_zone"],
        lastName: json["last_name"] == null ? '' : json["last_name"],
        firstName: json["first_name"] == null ? '' : json["first_name"],
        title: json["title"] == null ? '' : json["title"],
        registrationDate:
            json["registration_date"] == null ? '' : json["registration_date"],
        dateOfBirth: json["date_of_birth"] == null ? '' : json["date_of_birth"],
        agreeNewsletter:
            json["agree_newsletter"] == null ? false : json["agree_newsletter"],
        agreeNotifications: json["agree_notifications"] == null
            ? false
            : json["agree_notifications"],
        agreeTnc: json["agree_tnc"] == null ? false : json["agree_tnc"],
        testerFlag: json["tester_flag"] == null ? false : json["tester_flag"],
        emailList: json["email_list"] == null
            ? EmailList()
            : EmailList.fromJson(json["email_list"]),
        cellNumberList: json["cell_number_list"] == null
            ? []
            : List<CellNumberList>.from(json["cell_number_list"]
                .map((x) => CellNumberList.fromJson(x))),
        devices: json["devices"] == null
            ? []
            : List<String>.from(json["devices"].map((x) => x)),
        preferences: json["preferences"] == null
            ? Preferences()
            : Preferences.fromJson(json["preferences"]),
      );

  Map<String, dynamic> toJson() => {
        "social_media":
            socialMedia == null ? SocialMedia().toJson() : socialMedia.toJson(),
        "password": password == null ? '' : password,
        "user_name": userName == null ? '' : userName,
        "time_zone": timeZone == null ? '' : timeZone,
        "last_name": lastName == null ? '' : lastName,
        "first_name": firstName == null ? '' : firstName,
        "title": title == null ? '' : title,
        "registration_date": registrationDate == null ? '' : registrationDate,
        "date_of_birth": dateOfBirth == null ? '' : dateOfBirth,
        "agree_newsletter": agreeNewsletter == null ? false : agreeNewsletter,
        "agree_notifications":
            agreeNotifications == null ? false : agreeNotifications,
        "agree_tnc": agreeTnc == null ? false : agreeTnc,
        "tester_flag": testerFlag == null ? false : testerFlag,
        "email_list": emailList == null ? [] : emailList.toJson(),
        "cell_number_list": cellNumberList == null
            ? []
            : List<dynamic>.from(cellNumberList.map((x) => x.toJson())),
        "devices":
            devices == null ? [] : List<dynamic>.from(devices.map((x) => x)),
        "preferences":
            preferences == null ? Preferences().toJson() : preferences.toJson(),
      };
}
