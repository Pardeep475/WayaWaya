import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';

class LoyaltyBloc {
  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  String _status;

  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
        await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    debugPrint('main_menu_permission_testing:--   ${itemList.length}');
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }

  String get status => _status;

  setTotalBalance() async {
    try {
      String userData = await SessionManager.getUserData();
      UserDataResponse _response = userDataResponseFromJson(userData);
      if (_response == null) return;
      if (_response.loyaltyStatus == null) return;
      if (_response.loyaltyStatus['level'] == null) return;
      _status = _response.loyaltyStatus['level'];
      if (_response.loyaltyStatus['points'] == null) return;

      if (_response != null) {
        _status = _response.loyaltyStatus.level;
        // Timber.d("user loyalty status %s", mStatus);
//            mLoyalttotalBalanceyPointBalance = Integer.valueOf);
//         totalBalance.setText((mUserPreferenceData.getLoyaltyStatus().points()));
//         Timber.d("user loyalty status %s", mUserPreferenceData.getLoyaltyStatus().points());
      }
      debugPrint('loyaltyStatus:-  ${_response.loyaltyStatus}');
      //
    } catch (e) {}
  }
}
