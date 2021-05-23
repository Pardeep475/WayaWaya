import 'package:wayawaya/app/auth/signup/model/contact_number.dart';
import 'package:wayawaya/app/auth/signup/model/email_list.dart';
import 'package:wayawaya/app/auth/signup/model/guest_preferences.dart';
import 'package:wayawaya/app/auth/signup/model/loyalty_status.dart';
import 'package:wayawaya/app/auth/signup/model/social_media_model.dart';

class SignUpModel {
  SocialMedia social_media;
  String password;
  String user_name;
  String time_zone;
  String last_name;
  DateTime last_login;
  String first_name;
  String title;
  String registration_date;
  String date_of_birth;
  bool agree_newsletter;
  bool agree_notifications;
  bool agree_tnc;
  bool tester_flag;
  // String _id;
  EmailList email_list;
  List<ContactNumber> cell_number_list;
  List<String> devices;
  List<LoyaltyStatus> loyalty_status;
  GuestPreferences preferences;

  SignUpModel(
      {this.social_media,
      this.password,
      this.user_name,
      this.time_zone,
      this.last_name,
      this.last_login,
      this.first_name,
      this.title,
      this.registration_date,
      this.date_of_birth,
      this.agree_newsletter,
      this.agree_notifications,
      this.agree_tnc,
      this.tester_flag,
      // this._id,
      this.email_list,
      this.cell_number_list,
      this.devices,
      this.loyalty_status,
      this.preferences});
}
