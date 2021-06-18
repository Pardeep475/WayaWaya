import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:path/path.dart' as path;

class TwoDMapBloc {
  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
        await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }

  getMapUrl(String floorID) async {
    String defaultMall = await SessionManager.getDefaultMall();
    String mapDataJson = "$defaultMall.json";
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String mapDataUrl = Uri.encodeQueryComponent("file://$appDocPath/$mapDataJson");
    // URLEncoder.encode("file://" + MAP_DATA_PATH + mapDataJson, "UTF-8");

    String absolutePath = appDocDir.absolute.path;
    debugPrint('root_bundle:-   $appDocPath');
    debugPrint('root_bundle:-   $mapDataUrl');
  }
}
