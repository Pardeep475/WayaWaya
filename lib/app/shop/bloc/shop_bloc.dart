import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';

class ShopBloc {
  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  // ignore: close_sinks
  StreamController _listTypeController = StreamController<int>();

  StreamSink<int> get listTypeSink => _listTypeController.sink;

  Stream<int> get listTypeStream => _listTypeController.stream;

  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
        await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    debugPrint('main_menu_permission_testing:--   ${itemList.length}');
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }
}
