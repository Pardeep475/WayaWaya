import 'dart:convert';

GuestUserApiResponse guestUserApiResponseFromJson(String str) => GuestUserApiResponse.fromJson(json.decode(str));

String guestUserApiResponseToJson(GuestUserApiResponse data) => json.encode(data.toJson());

class GuestUserApiResponse {
  GuestUserApiResponse({
    // this.id,
    this.firstName,
    this.socialMedia,
    // this.timeZone,
    // this.userName,
    // this.agreeNotifications,
    // this.devices,
    // this.registrationDate,
    // this.password,
    // this.emailList,
    // this.lastName,
    // this.dateOfBirth,
    // this.agreeTnc,
    // this.title,
    // this.cellNumberList,
    // this.agreeNewsletter,
    // this.updated,
    // this.created,
    // this.testerFlag,
    // this.registeredFromNewsletter,
    // this.age,
    // this.loginFlag,
    // this.preferences,
    // this.loyaltyStatus,
    // this.links,
  });

  // String id;
  String firstName;
  SocialMedia socialMedia;
  // String timeZone;
  // String userName;
  // bool agreeNotifications;
  // List<String> devices;
  // String registrationDate;
  // String password;
  // EmailList emailList;
  // String lastName;
  // DateTime dateOfBirth;
  // bool agreeTnc;
  // String title;
  // List<CellNumberList> cellNumberList;
  // bool agreeNewsletter;
  // String updated;
  // String created;
  // bool testerFlag;
  // bool registeredFromNewsletter;
  // int age;
  // bool loginFlag;
  // Preferences preferences;
  // LoyaltyStatus loyaltyStatus;
  // Links links;

  factory GuestUserApiResponse.fromJson(Map<String, dynamic> json) => GuestUserApiResponse(
    // id: json["_id"] == null ? null : json["_id"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    socialMedia: json["social_media"] == null ? null : SocialMedia.fromJson(json["social_media"]),
    // timeZone: json["time_zone"] == null ? null : json["time_zone"],
    // userName: json["user_name"] == null ? null : json["user_name"],
    // agreeNotifications: json["agree_notifications"] == null ? null : json["agree_notifications"],
    // devices: json["devices"] == null ? null : List<String>.from(json["devices"].map((x) => x)),
    // registrationDate: json["registration_date"] == null ? null : json["registration_date"],
    // password: json["password"] == null ? null : json["password"],
    // emailList: json["email_list"] == null ? null : EmailList.fromJson(json["email_list"]),
    // lastName: json["last_name"] == null ? null : json["last_name"],
    // dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    // agreeTnc: json["agree_tnc"] == null ? null : json["agree_tnc"],
    // title: json["title"] == null ? null : json["title"],
    // cellNumberList: json["cell_number_list"] == null ? null : List<CellNumberList>.from(json["cell_number_list"].map((x) => CellNumberList.fromJson(x))),
    // agreeNewsletter: json["agree_newsletter"] == null ? null : json["agree_newsletter"],
    // updated: json["_updated"] == null ? null : json["_updated"],
    // created: json["_created"] == null ? null : json["_created"],
    // testerFlag: json["tester_flag"] == null ? null : json["tester_flag"],
    // registeredFromNewsletter: json["registered_from_newsletter"] == null ? null : json["registered_from_newsletter"],
    // age: json["age"] == null ? null : json["age"],
    // loginFlag: json["login_flag"] == null ? null : json["login_flag"],
    // preferences: json["preferences"] == null ? null : Preferences.fromJson(json["preferences"]),
    // loyaltyStatus: json["loyalty_status"] == null ? null : LoyaltyStatus.fromJson(json["loyalty_status"]),
    // links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    // "_id": id == null ? null : id,
    "first_name": firstName == null ? null : firstName,
    "social_media": socialMedia == null ? null : socialMedia.toJson(),
    // "time_zone": timeZone == null ? null : timeZone,
    // "user_name": userName == null ? null : userName,
    // "agree_notifications": agreeNotifications == null ? null : agreeNotifications,
    // "devices": devices == null ? null : List<dynamic>.from(devices.map((x) => x)),
    // "registration_date": registrationDate == null ? null : registrationDate,
    // "password": password == null ? null : password,
    // "email_list": emailList == null ? null : emailList.toJson(),
    // "last_name": lastName == null ? null : lastName,
    // "date_of_birth": dateOfBirth == null ? null : dateOfBirth.toIso8601String(),
    // "agree_tnc": agreeTnc == null ? null : agreeTnc,
    // "title": title == null ? null : title,
    // "cell_number_list": cellNumberList == null ? null : List<dynamic>.from(cellNumberList.map((x) => x.toJson())),
    // "agree_newsletter": agreeNewsletter == null ? null : agreeNewsletter,
    // "_updated": updated == null ? null : updated,
    // "_created": created == null ? null : created,
    // "tester_flag": testerFlag == null ? null : testerFlag,
    // "registered_from_newsletter": registeredFromNewsletter == null ? null : registeredFromNewsletter,
    // "age": age == null ? null : age,
    // "login_flag": loginFlag == null ? null : loginFlag,
    // "preferences": preferences == null ? null : preferences.toJson(),
    // "loyalty_status": loyaltyStatus == null ? null : loyaltyStatus.toJson(),
    // "_links": links == null ? null : links.toJson(),
  };
}

class CellNumberList {
  CellNumberList({
    this.data,
    this.type,
  });

  String data;
  String type;

  factory CellNumberList.fromJson(Map<String, dynamic> json) => CellNumberList(
    data: json["data"] == null ? null : json["data"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data,
    "type": type == null ? null : type,
  };
}

class EmailList {
  EmailList({
    this.type,
    this.value,
    this.mode,
  });

  String type;
  String value;
  String mode;

  factory EmailList.fromJson(Map<String, dynamic> json) => EmailList(
    type: json["type"] == null ? null : json["type"],
    value: json["value"] == null ? null : json["value"],
    mode: json["mode"] == null ? null : json["mode"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "value": value == null ? null : value,
    "mode": mode == null ? null : mode,
  };
}

class Links {
  Links({
    this.parent,
    this.self,
    this.collection,
  });

  Collection parent;
  Collection self;
  Collection collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    parent: json["parent"] == null ? null : Collection.fromJson(json["parent"]),
    self: json["self"] == null ? null : Collection.fromJson(json["self"]),
    collection: json["collection"] == null ? null : Collection.fromJson(json["collection"]),
  );

  Map<String, dynamic> toJson() => {
    "parent": parent == null ? null : parent.toJson(),
    "self": self == null ? null : self.toJson(),
    "collection": collection == null ? null : collection.toJson(),
  };
}

class Collection {
  Collection({
    this.title,
    this.href,
  });

  String title;
  String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    title: json["title"] == null ? null : json["title"],
    href: json["href"] == null ? null : json["href"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "href": href == null ? null : href,
  };
}

class LoyaltyStatus {
  LoyaltyStatus({
    this.points,
    this.level,
    // this.label,
  });

  int points;
  int level;
  // List<Label> label;

  factory LoyaltyStatus.fromJson(Map<String, dynamic> json) => LoyaltyStatus(
    points: json["points"] == null ? null : json["points"],
    level: json["level"] == null ? null : json["level"],
    // label: json["label"] == null ? null : List<Label>.from(json["label"].map((x) => Label.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "points": points == null ? null : points,
    "level": level == null ? null : level,
    // "label": label == null ? null : List<dynamic>.from(label.map((x) => x.toJson())),
  };
}

class Label {
  Label({
    this.text,
    this.language,
  });

  String text;
  String language;

  factory Label.fromJson(Map<String, dynamic> json) => Label(
    text: json["text"] == null ? null : json["text"],
    language: json["language"] == null ? null : json["language"],
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "language": language == null ? null : language,
  };
}

class Preferences {
  Preferences({
    this.favoriteMalls,
    this.categories,
    this.defaultLanguage,
    this.notification,
    this.alternateCurrency,
  });

  String favoriteMalls;
  List<String> categories;
  String defaultLanguage;
  int notification;
  String alternateCurrency;

  factory Preferences.fromJson(Map<String, dynamic> json) => Preferences(
    favoriteMalls: json["favorite_malls"] == null ? null : json["favorite_malls"],
    categories: json["categories"] == null ? null : List<String>.from(json["categories"].map((x) => x)),
    defaultLanguage: json["default_language"] == null ? null : json["default_language"],
    notification: json["notification"] == null ? null : json["notification"],
    alternateCurrency: json["alternate_currency"] == null ? null : json["alternate_currency"],
  );

  Map<String, dynamic> toJson() => {
    "favorite_malls": favoriteMalls == null ? null : favoriteMalls,
    "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x)),
    "default_language": defaultLanguage == null ? null : defaultLanguage,
    "notification": notification == null ? null : notification,
    "alternate_currency": alternateCurrency == null ? null : alternateCurrency,
  };
}

class SocialMedia {
  SocialMedia({
    this.token,
    this.socialId,
    this.type,
  });

  String token;
  String socialId;
  String type;

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
    token: json["token"] == null ? null : json["token"],
    socialId: json["social_id"] == null ? null : json["social_id"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "social_id": socialId == null ? null : socialId,
    "type": type == null ? null : type,
  };
}
