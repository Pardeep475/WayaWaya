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

//   void setIsLogin(bool isLogin) async {
//     _pref.then((value) => value.setBool(AppString.IS_LOGIN, isLogin));
//   }
//
//   Future<bool> isLogin() {
//     return _pref.then((value) => value.getBool(AppString.IS_LOGIN) ?? false);
//   }
//
//   void setClientId(String clientId) async {
//     _pref.then((value) => value.setString(AppString.CLIENT_ID, clientId));
//   }
//
//   Future<String> getClientId() {
//     return _pref.then((value) => value.getString(AppString.CLIENT_ID) ?? "0");
//   }
//
//   void setInvoiceAmount(String amount) async {
//     _pref.then((value) => value.setString(AppString.INVOICE_AMOUNT, amount));
//   }
//
//   Future<String> getInvoiceAmount() {
//     return _pref
//         .then((value) => value.getString(AppString.INVOICE_AMOUNT) ?? "\$0");
//   }
//
//   void setInvoiceCount(String count) async {
//     _pref.then((value) => value.setString(AppString.INVOICE_COUNT, count));
//   }
//
//   Future<String> getInvoiceCount() {
//     return _pref
//         .then((value) => value.getString(AppString.INVOICE_COUNT) ?? "");
//   }
//
// //  USER_DATA
//   void setUserData(String userData) async {
//     _pref.then((value) => value.setString(AppString.USER_DATA, userData));
//   }
//
//   Future<String> getUserData() {
//     return _pref.then((value) => value.getString(AppString.USER_DATA) ?? false);
//   }

  void clearAllData() {
    _pref.then((value) {
      value.clear();
    });
  }
}
