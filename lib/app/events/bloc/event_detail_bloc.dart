import 'dart:async';

import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';

class EventDetailBloc {
  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  List<MainMenuPermission> _mainMenuList = [];

  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
        await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    _mainMenuList = itemList;
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }

  List<MainMenuPermission> get mainMenuList => _mainMenuList;
}
