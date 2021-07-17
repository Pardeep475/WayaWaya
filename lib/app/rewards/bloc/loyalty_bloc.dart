import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_new.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_points.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_response.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_temp.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class LoyaltyBloc {
  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  String _status;

  static final _repository = ApiRepository();

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

  static syncLoyalty() async {
    Utils.checkConnectivity().then((value) async {
      if (value != null && value) {
        try {
          String authToken = await SessionManager.getJWTToken();
          String userData = await SessionManager.getUserData();
          UserDataResponse _response = userDataResponseFromJson(userData);
          String userId = _response.userId;
          fetchLoyaltyFromNetwork(
              page: 1, userID: userId, authToken: authToken);
        } catch (e) {
          loadLoyaltyMonthData();
        }
      } else {
        loadLoyaltyMonthData();
      }
    });
  }

  static fetchLoyaltyFromNetwork(
      {int page, String authToken, String userID}) async {
    try {
      Map<String, dynamic> loyaltyQuery = {
        "page": page.toString(),
        "sort": "-event_timestamp",
        "enable": true,
        "where": "{\"points\":{\"\$gt\":0},\"user_id\":\"" + userID + "\"}",
      };

      dynamic _loyaltyData = await _repository.loyaltyApiRepository(
          authorization: authToken, map: loyaltyQuery);
      debugPrint("testing__:-  success $_loyaltyData");
      if (_loyaltyData is DioError) {
        // refresh token
        updateRefreshToken(pageNo: page, loyalty: null, monthNo: -1);
      } else {
        LoyaltyResponse _loyaltyResponse =
            LoyaltyResponse.fromJson(_loyaltyData.data);
        debugPrint("testing__:-  success ${_loyaltyResponse.items.length}");

        if (_loyaltyResponse.links != null) {
          if (_loyaltyResponse.links.next != null) {
            fetchLoyaltyFromNetwork(
                page: page + 1, userID: userID, authToken: authToken);
          }
        }
      }
    } catch (e) {
      debugPrint("error_in_login_api:-  $e");
      loadLoyaltyMonthData();
    }
  }

  static updateRefreshToken(
      {int pageNo, LoyaltyNew loyalty, int monthNo}) async {
    Utils.checkConnectivity().then((value) async {
      try {
        if (value != null && value) {
          dynamic _refreshTokenApiResponse =
              await _repository.refreshTokenApiRepository();
          if (_refreshTokenApiResponse is DioError) {
            // logout button functionality
          } else {
            SessionManager.setJWTToken(
                _refreshTokenApiResponse.data['access_token']);
            SessionManager.setRefreshToken(
                _refreshTokenApiResponse.data['refresh_token']);
            syncLoyalty();
          }
        }
      } catch (e) {
        // logout button functionality
      }
    });
  }

  static loadLoyaltyMonthData() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<LoyaltyTemp> _serviceList = await ProfileDatabaseHelper.getLoyaltyData(
      databasePath: defaultMall,
    );
  }

  static loadLoyaltyUserPoint() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<LoyaltyPoints> _serviceList =
    await ProfileDatabaseHelper.getLoyaltyUserPoints(
      databasePath: defaultMall,
    );

    _serviceList.forEach((element) {
      debugPrint(' ${element.availablePoints}    \n   ${element.redeemed}');
    });
  }

}
