import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/map/model/service_model.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';

class TheMallBloc {
  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  // ignore: close_sinks
  StreamController _serviceController =
      StreamController<ApiResponse<List<ServiceModel>>>();

  StreamSink<ApiResponse<List<ServiceModel>>> get serviceSink =>
      _serviceController.sink;

  Stream<ApiResponse<List<ServiceModel>>> get serviceStream =>
      _serviceController.stream;

  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
        await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }

  fetchServicesData() async {
    serviceSink.add(ApiResponse.loading(null));
    try {
      String defaultMall = await SessionManager.getDefaultMall();
      List<ServiceModel> _serviceList =
          await ProfileDatabaseHelper.getAllServices(
        databasePath: defaultMall,
      );
      serviceSink.add(ApiResponse.completed(_serviceList));
    } catch (e) {
      serviceSink.add(ApiResponse.error(e));
    }

    // _serviceList.forEach((element) {
    //   debugPrint(' ${element.sequenceNumber}');
    // });
  }
}
