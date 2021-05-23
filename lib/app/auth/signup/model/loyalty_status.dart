import 'package:wayawaya/app/auth/signup/model/language_store.dart';

Map<String, dynamic> loyaltyStatusModelToJson(LoyaltyStatus data) =>
    /*json.encode(*/ data.toJson() /*)*/;

class LoyaltyStatus {
  String points;
  String level;
  List<LanguageStore> label;

  LoyaltyStatus({this.points, this.level, this.label});

  Map<String, dynamic> toJson() => {
        "points": points,
        "level": level,
        "label": label != null ? label.toString() : null,
      };
}
