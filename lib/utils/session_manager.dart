import 'package:shared_preferences/shared_preferences.dart';

import 'app_strings.dart';

class SessionManager {
  static final SessionManager _sessionManager = SessionManager._internal();

  factory SessionManager() {
    return _sessionManager;
  }

  SessionManager._internal();

  static final Future<SharedPreferences> _pref =
      SharedPreferences.getInstance();

  static void setFirstTime(bool isFirstTime) {
    _pref.then((value) => value.setBool(AppString.IS_FIRST_TIME, isFirstTime));
  }

  static Future<bool> isFirstTime() {
    return _pref
        .then((value) => value.getBool(AppString.IS_FIRST_TIME) ?? false);
  }

  static void setAuthHeader(String authHeader) async {
    _pref.then((value) => value.setString(AppString.AUTH_HEADER, authHeader));
  }

  static Future<String> getAuthHeader() {
    return _pref.then((value) => value.getString(AppString.AUTH_HEADER) ?? "");
  }

  static void setDefaultMall(String defaultMall) async {
    _pref.then((value) => value.setString(AppString.DEFAULT_MALL, defaultMall));
  }

  static Future<String> getDefaultMall() {
    return _pref.then((value) => value.getString(AppString.DEFAULT_MALL) ?? "");
  }

  static void setCurrentDevice(String currentDevice) async {
    _pref.then(
        (value) => value.setString(AppString.CURRENT_DEVICE, currentDevice));
  }

  static Future<String> getCurrentDevice() {
    return _pref
        .then((value) => value.getString(AppString.CURRENT_DEVICE) ?? "");
  }

  static void setJWTToken(String jwtToken) async {
    _pref.then((value) => value.setString(AppString.JWT_TOKEN, jwtToken));
  }

  static Future<String> getJWTToken() {
    return _pref.then((value) => value.getString(AppString.JWT_TOKEN) ?? "");
  }

  static void setRefreshToken(String refreshToken) async {
    _pref.then(
        (value) => value.setString(AppString.REFRESH_TOKEN, refreshToken));
  }

  static Future<String> getRefreshToken() {
    return _pref
        .then((value) => value.getString(AppString.REFRESH_TOKEN) ?? "");
  }

//  USER_DATA
  static void setUserData(String userData) async {
    _pref.then((value) => value.setString(AppString.USER_DATA, userData));
  }

  static Future<String> getUserData() {
    return _pref.then((value) => value.getString(AppString.USER_DATA) ?? false);
  }

  void clearAllData() {
    _pref.then((value) {
      value.clear();
    });
  }
}
