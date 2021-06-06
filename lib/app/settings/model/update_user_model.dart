import 'dart:convert';

import 'package:wayawaya/app/common/model/contact_number.dart';

UpdateUserModel updateUserModelResponseFromJson(String str) =>
    UpdateUserModel.fromJson(json.decode(str));

String updateUserModelResponseToJson(UpdateUserModel data) =>
    json.encode(data.toJson());

class UpdateUserModel {
  String title;
  String firstName;
  String lastName;
  String dateOfBirthAccuracy;
  String dateOfBirth;
  List<CellNumberList> cellNumberList;

  UpdateUserModel(
      {this.title,
      this.firstName,
      this.lastName,
      this.dateOfBirthAccuracy,
      this.dateOfBirth,
      this.cellNumberList});

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserModel(
        title: json["title"] == null ? '' : json["title"],
        firstName: json["first_name"] == null ? '' : json["first_name"],
        lastName: json["last_name"] == null ? '' : json["last_name"],
        dateOfBirthAccuracy: 'actual',
        dateOfBirth: json["date_of_birth"] == null ? '' : json["date_of_birth"],
        cellNumberList: json["cell_number_list"] == null
            ? []
            : List<CellNumberList>.from(json["cell_number_list"]
                .map((x) => CellNumberList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? '' : title,
        "first_name": firstName == null ? '' : firstName,
        "last_name": lastName == null ? '' : lastName,
        "date_of_birth_accuracy":
            dateOfBirthAccuracy == null ? 'actual' : dateOfBirthAccuracy,
        "date_of_birth": dateOfBirth == null ? '' : dateOfBirth,
        "cell_number_list": cellNumberList == null
            ? []
            : List<dynamic>.from(cellNumberList.map((x) => x.toJson())),
      };
}
