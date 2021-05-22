import 'dart:convert';

UserDataResponse userDataResponseFromJson(String str) =>
    UserDataResponse.fromJson(json.decode(str));

String userDataResponseToJson(UserDataResponse data) =>
    json.encode(data.toJson());

class UserDataResponse {
  String userId;
  String email;
  String password;
  String name;
  String roleId;
  String role;
  String createdBy;
  String createdDtm;
  String image;
  String isDeleted;
  String mobile;
  String updatedDtm;
  String updatedBy;
  int totalInvoices;
  int totalAmount;
  String clientId;
  String companyName;
  int total_pre_invoices;
  int total_pre_amount;

  UserDataResponse(
      {this.password,
        this.name,
        this.roleId,
        this.email,
        this.role,
        this.createdBy,
        this.createdDtm,
        this.image,
        this.isDeleted,
        this.mobile,
        this.updatedBy,
        this.updatedDtm,
        this.totalInvoices,
        this.totalAmount,
        this.clientId,
        this.companyName,
        this.total_pre_invoices,
        this.total_pre_amount,
        this.userId});

  UserDataResponse.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    name = json['name'];
    email = json['email'];
    roleId = json['roleId'];
    userId = json['userId'];
    role = json['role'];
    createdBy = json['createdBy'];
    image = json['image'];
    isDeleted = json['isDeleted'];
    mobile = json['mobile'];
    updatedBy = json['updatedBy'];
    updatedDtm = json['updatedDtm'];
    totalInvoices = json['total_invoices'];
    totalAmount = json['total_amount'];
    clientId = json['client_id'];
    companyName = json['company_name'];
    total_pre_invoices = json['total_pre_invoices'];
    total_pre_amount = json['total_pre_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['roleId'] = this.roleId;
    data['role'] = this.roleId;
    data['email'] = this.email;
    data['createdBy'] = this.createdBy;
    data['createdDtm'] = this.createdDtm;
    data['image'] = this.image;
    data['isDeleted'] = this.isDeleted;
    data['mobile'] = this.mobile;
    data['updatedBy'] = this.updatedBy;
    data['updatedDtm'] = this.updatedDtm;
    data['total_invoices'] = this.totalInvoices;
    data['total_amount'] = this.totalAmount;
    data['client_id'] = this.clientId;
    data['company_name'] = this.companyName;
    data['total_pre_invoices'] = this.total_pre_invoices;
    data['total_pre_amount'] = this.total_pre_amount;
    return data;
  }
}
