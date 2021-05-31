import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';

class App {
  static const String appName = ' Waya Waya';
  static TextTheme theme(BuildContext context) => Theme.of(context).textTheme;
  static Future<dynamic> pushTo({BuildContext context, screen}) => Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => screen),
  );

  static SharedPreferences prefs;

  static User user;

  static final String id = 'id';
  static final String email = 'email';
  static final String firstName = 'firstName';
  static final String lastName = 'lastName';
  static final String dob = 'dob';
  static final String password = 'password';
  static final String phone = 'phone';

  static height(BuildContext context) => MediaQuery.of(context).size.height;
  static width(BuildContext context) => MediaQuery.of(context).size.width;
}
