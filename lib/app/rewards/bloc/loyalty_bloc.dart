import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/rewards/model/child_expandable_model.dart';
import 'package:wayawaya/app/rewards/model/expandable_model.dart';
import 'package:wayawaya/app/rewards/model/header_expandable_model.dart';
import 'package:wayawaya/app/rewards/model/loyalty_points.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/network/local/database_helper_two.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_header_response.dart';
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

  StreamController _totalPointController =
      StreamController<LoyaltyPointsModel>();

  StreamSink<LoyaltyPointsModel> get totalPointSink =>
      _totalPointController.sink;

  Stream<LoyaltyPointsModel> get totalPointStream =>
      _totalPointController.stream;

  StreamController _pieChartController = StreamController<LoyaltyPoints>();

  StreamSink<LoyaltyPoints> get pieChartSink => _pieChartController.sink;

  Stream<LoyaltyPoints> get pieChartStream => _pieChartController.stream;

  StreamController _expandableListController =
      StreamController<List<ExpandableModel>>();

  StreamSink<List<ExpandableModel>> get expandableListSink =>
      _expandableListController.sink;

  Stream<List<ExpandableModel>> get expandableListStream =>
      _expandableListController.stream;

  static final _repository = ApiRepository();

  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
        await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }

  setTotalBalance() async {
    try {
      String userData = await SessionManager.getUserData();
      UserDataResponse _response = userDataResponseFromJson(userData);
      if (_response == null) return;
      if (_response.loyaltyStatus == null) return;
      dynamic loyaltyStatus = jsonDecode(_response.loyaltyStatus);
      if (loyaltyStatus['level'] == null) return;
      if (loyaltyStatus['points'] == null) return;
      LoyaltyPointsModel _loyaltyPoint = LoyaltyPointsModel();
      _loyaltyPoint.status = loyaltyStatus['level'];
      _loyaltyPoint.points = loyaltyStatus['points'].toString();
      totalPointSink.add(_loyaltyPoint);
    } catch (e) {
      debugPrint('set_total_balance:-  $e');
    }
  }

  syncLoyalty() async {
    Utils.checkConnectivity().then((value) async {
      if (value != null && value) {
        try {
          String authToken = await SessionManager.getJWTToken();
          String userData = await SessionManager.getUserData();
          UserDataResponse _response = userDataResponseFromJson(userData);
          String userId = _response.userId;
          await fetchLoyaltyFromNetwork(
              page: 1, userID: userId, authToken: authToken);
          loadLoyaltyMonthData();
        } catch (e) {
          loadLoyaltyMonthData();
        }
      } else {
        loadLoyaltyMonthData();
      }
    });
  }

  fetchLoyaltyFromNetwork({int page, String authToken, String userID}) async {
    try {
      String where = "";
      String latestLoyalty = await DataBaseHelperTwo.latestLoyalty();

      if (latestLoyalty == null) {
        where = "{\"points\":{\"\$gt\":0},\"user_id\":\"" + userID + "\"}";
      } else {
        where = "{\"event_timestamp\":{\"\$gt\": \"" +
            latestLoyalty +
            "\"},\"points\":{\"\$gt\":0},\"user_id\":\"" +
            userID +
            "\"}";
      }

      Map<String, dynamic> loyaltyQuery = {
        "page": page.toString(),
        "sort": "-event_timestamp",
        "enable": true,
        "where": where,
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
        // set data to database
        await DataBaseHelperTwo.setLoyaltyToDataBase(_loyaltyResponse.items);
        int count = await DataBaseHelperTwo.loyaltyTableLength();
        debugPrint('loyalty_count:-   $count');
        if (_loyaltyResponse.links != null) {
          if (_loyaltyResponse.links.next != null) {
            fetchLoyaltyFromNetwork(
                page: page + 1, userID: userID, authToken: authToken);
          }
        }
      }
    } catch (e) {
      debugPrint("error_in_fetchLoyaltyFromNetwork:-  $e");
      loadLoyaltyMonthData();
    }
  }

  updateRefreshToken({int pageNo, LoyaltyNew loyalty, int monthNo}) async {
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

  loadLoyaltyMonthData() async {
    try {
      await loadLoyaltyUserPoint();

      String defaultMall = await SessionManager.getDefaultMall();
      List<LoyaltyHeaderResponse> _loyaltyHeaderResponseList =
          await ProfileDatabaseHelper.getLoyaltyData(
        databasePath: defaultMall,
      );
      debugPrint('services_list:-   ${_loyaltyHeaderResponseList.length}');
      List<ExpandableModel> expandableList = [];
      _loyaltyHeaderResponseList.forEach((element) async {
        List<ChildExpandableModel> childList =
            await loadLoyaltyMonthChildData(defaultMall, element.month);
        String date = Utils.dateConvert(element.timestamp, "MMMM, yyyy");
        HeaderExpandableModel _headerExpandableModel = HeaderExpandableModel(
            date: date, points: element.totalMonthPoints.toString());
        ExpandableModel expandableModel = ExpandableModel(
            headerExpandableModel: _headerExpandableModel,
            childExpandableModel: childList);
        expandableList.add(expandableModel);
        if (_loyaltyHeaderResponseList.length == expandableList.length) {
          expandableListSink.add(expandableList);
        }
      });
      expandableListSink.add(expandableList);
    } catch (e) {
      debugPrint('expandable:-  $e');
      expandableListSink.add([]);
    }
  }

  Future<List<ChildExpandableModel>> loadLoyaltyMonthChildData(
      String defaultMall, String month) async {
    try {
      List<ChildExpandableModel> _childExpandableModelList = [];

      List<LoyaltyData> timeStamp =
          await ProfileDatabaseHelper.getLoyaltyTransaction(
              databasePath: defaultMall, month: int.parse(month));
      debugPrint('loyalty_data_length ${timeStamp.length}');
      timeStamp.forEach((element) {
        ChildExpandableModel _childExpandableModel = ChildExpandableModel(
            date: Utils.dateConvert(element.eventTimestamp, "d, MMM"),
            description: element.description,
            iconData: getIconData(element.type),
            points: element.points.toString());

        _childExpandableModelList.add(_childExpandableModel);
      });
      return _childExpandableModelList;
    } catch (e) {
      return [];
    }
  }

  IconData getIconData(String type) {
    switch (type) {
      case "purchase":
        // holder.loyaltyPlusMinus.setText("{md-shop}");
        return Icons.shop;
      case "visit":
        // holder.loyaltyPlusMinus.setText("{md-directions-walk}");
        return Icons.directions_walk;
      case "register":
        // holder.loyaltyPlusMinus.setText("{md-account-box}");
        return Icons.account_box;
      case "app_open":
        // holder.loyaltyPlusMinus.setText("{md-phone-android}");
        return Icons.phone_android;
      case "redemption":
        // holder.loyaltyPlusMinus.setText("{md-redeem}");
        return Icons.redeem;
      case "view_offer":
        // holder.loyaltyPlusMinus.setText("{md-local-offer}");
        return Icons.local_offer;
      case "mall_visit":
        // holder.loyaltyPlusMinus.setText("{md-local-mall}");
        return Icons.local_mall;
      case "store_visit":
        // holder.loyaltyPlusMinus.setText("{md-shop}");
        return Icons.shop;
      default:
        {
          return Icons.phone_android;
        }
    }
  }

  loadLoyaltyUserPoint() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<LoyaltyPoints> _serviceList =
        await ProfileDatabaseHelper.getLoyaltyUserPoints(
      databasePath: defaultMall,
    );
    debugPrint('loadLoyaltyUserPoint:-   ${_serviceList.length}');
    _serviceList.forEach((element) {
      debugPrint(' ${element.availablePoints}    \n   ${element.redeemed}');
    });

    if (_serviceList.isNotEmpty) {
      pieChartSink.add(_serviceList[0]);
    }
  }
}
