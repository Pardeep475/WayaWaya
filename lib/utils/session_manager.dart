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

  static Future<String> getSyncDate() async {
    return _pref.then((value) => value.getString(AppString.SYNC_DATE));
  }

  static void setUserInMall(bool userInMall) async {
    _pref.then((value) => value.setBool(AppString.USER_IN_MALL, userInMall));
  }

  static Future<bool> getUserInMall() async {
    return _pref.then((value) => value.getBool(AppString.USER_IN_MALL) ?? true);
  }

  static void setGestureHome(bool gestureHome) async {
    _pref.then((value) => value.setBool(AppString.GESTURE_HOME, gestureHome));
  }

  static Future<bool> getGestureHome() async {
    return _pref.then((value) => value.getBool(AppString.GESTURE_HOME) ?? true);
  }

  static void setGestureMenu(bool gestureMenu) async {
    _pref.then((value) => value.setBool(AppString.GESTURE_MENU, gestureMenu));
  }

  static Future<bool> getGestureMenu() async {
    return _pref.then((value) => value.getBool(AppString.GESTURE_MENU) ?? true);
  }

  static void setGestureRetailUnit(bool gestureRetailUnit) async {
    _pref.then((value) =>
        value.setBool(AppString.GESTURE_DETAIL_RETAIL_UNIT, gestureRetailUnit));
  }

  static Future<bool> getGestureRetailUnit() async {
    return _pref.then(
        (value) => value.getBool(AppString.GESTURE_DETAIL_RETAIL_UNIT) ?? true);
  }

  static void setGestureMap(bool gestureRetailMap) async {
    _pref.then(
        (value) => value.setBool(AppString.GESTURE_MAP, gestureRetailMap));
  }

  static Future<bool> getGestureMap() async {
    return _pref.then((value) => value.getBool(AppString.GESTURE_MAP) ?? true);
  }

  static void setGestureRewards(bool gestureRewards) async {
    _pref.then(
        (value) => value.setBool(AppString.GESTURE_REWARDS, gestureRewards));
  }

  static Future<bool> getGestureRewards() async {
    return _pref
        .then((value) => value.getBool(AppString.GESTURE_REWARDS) ?? true);
  }

  static void setGestureLoyalty(bool gestureLoyalty) async {
    _pref.then(
        (value) => value.setBool(AppString.GESTURE_LOYALTY, gestureLoyalty));
  }

  static Future<bool> getGestureLoyalty() async {
    return _pref
        .then((value) => value.getBool(AppString.GESTURE_LOYALTY) ?? true);
  }

  // static void putOfferOpenLoyaltyJson(OfferOpenLoyaltyData OfferOpenLoyaltyData) {
  //   String OfferOpenLoyaltyDataJson = mGson.toJson(OfferOpenLoyaltyData);
  //   mPref.edit().putString(PREF_OFFER_OPEN_JSON, OfferOpenLoyaltyDataJson).apply();
  //
  //   Timber.d("OFFER_OPEN_LOYALTY: %s , %s", "OfferOpenLoyaltyData after set : ", getOfferOpenLoyaltyData().toString());
  // }
  //
  // public OfferOpenLoyaltyData getOfferOpenLoyaltyData() {
  //   return mGson.fromJson(mPref.getString(PREF_OFFER_OPEN_JSON, null),
  //       OfferOpenLoyaltyData.class);
  // }

  void clearAllData() {
    _pref.then((value) {
      value.clear();
    });
  }
}
