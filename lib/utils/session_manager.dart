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

  static void setISLogin(bool isLogin) {
    _pref.then((value) => value.setBool(AppString.IS_LOGIN, isLogin));
  }

  static Future<bool> isLogin() {
    return _pref.then((value) => value.getBool(AppString.IS_LOGIN) ?? null);
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
    return _pref.then((value) => value.getString(AppString.USER_DATA));
  }

  static void setSmallDefaultMallData(String smallMallDefaultData) async {
    _pref.then((value) => value.setString(
        AppString.SMALL_DEFAULT_MALL_DATA, smallMallDefaultData));
  }

  static Future<String> getSmallDefaultMallData() {
    return _pref
        .then((value) => value.getString(AppString.SMALL_DEFAULT_MALL_DATA));
  }

  static void setISLoginScreenVisible(bool isLoginScreenVisible) async {
    _pref.then((value) =>
        value.setBool(AppString.IS_LOGIN_SCREEN_VISIBLE, isLoginScreenVisible));
  }

  static Future<bool> getISLoginScreenVisible() {
    return _pref.then(
        (value) => value.getBool(AppString.IS_LOGIN_SCREEN_VISIBLE) ?? false);
  }

  static void setGuestUserLanguage(String language) async {
    _pref.then((value) =>
        value.setString(AppString.PREF_GUEST_USER_LANGUAGE, language));
  }

  static Future<String> getGuestUserLanguage() {
    return _pref
        .then((value) => value.getString(AppString.PREF_GUEST_USER_LANGUAGE));
  }

  static void setGuestUserCurrency(String currency) async {
    _pref.then((value) =>
        value.setString(AppString.PREF_GUEST_USER_CURRENCY, currency));
  }

  static Future<String> getGuestUserCurrency() {
    return _pref
        .then((value) => value.getString(AppString.PREF_GUEST_USER_CURRENCY));
  }

  static void setGuestUserFavouriteMall(String favouriteMall) async {
    _pref.then((value) => value.setString(
        AppString.PREF_GUEST_USER_FAVOURITE_MALL, favouriteMall));
  }

  static Future<String> getGuestUserFavouriteMall() {
    return _pref.then(
        (value) => value.getString(AppString.PREF_GUEST_USER_FAVOURITE_MALL));
  }

  static void setGuestUserNotification(int notification) async {
    _pref.then((value) =>
        value.setInt(AppString.PREF_GUEST_USER_NOTIFICATIONS, notification));
  }

  static Future<int> getGuestUserNotification() {
    return _pref
        .then((value) => value.getInt(AppString.PREF_GUEST_USER_NOTIFICATIONS));
  }

  static void setGuestUserCategory(String categories) async {
    _pref.then((value) =>
        value.setString(AppString.PREF_GUEST_USER_CATEGORIES, categories));
  }

  static Future<String> getGuestUserCategory() {
    return _pref
        .then((value) => value.getString(AppString.PREF_GUEST_USER_CATEGORIES));
  }

  static void setSyncDate(String syncDate) async {
    _pref.then((value) => value.setString(AppString.SYNC_DATE, syncDate));
  }

  static Future<String> getSyncDate() {
    return _pref.then((value) => value.getString(AppString.SYNC_DATE));
  }

  void clearAllData() {
    _pref.then((value) {
      value.clear();
    });
  }
}
