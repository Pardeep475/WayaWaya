import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/shop/model/retail_with_category.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';

class ShopDetailBloc {
  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  // ignore: close_sinks
  StreamController _indicatorController = StreamController<int>();

  StreamSink<int> get indicatorSink => _indicatorController.sink;

  Stream<int> get indicatorStream => _indicatorController.stream;

  final _gestureDetailRetailUnitController = StreamController<bool>.broadcast();

  StreamSink<bool> get gestureDetailRetailUnitSink =>
      _gestureDetailRetailUnitController.sink;

  Stream<bool> get gestureDetailRetailUnitStream =>
      _gestureDetailRetailUnitController.stream;

  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
        await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }

  updateFavourite({RetailWithCategory retailWithCategory}) async {
    String defaultMall = await SessionManager.getDefaultMall();
    await ProfileDatabaseHelper.updateRetailWithCategory(
        databasePath: defaultMall,
        retailUnitId: retailWithCategory.id,
        flag: retailWithCategory.favourite == "0" ? "1" : "0");
  }

  setUpGestureRetailUnit() async{
    bool value = await SessionManager.getGestureRetailUnit();
    gestureDetailRetailUnitSink.add(value);
  }

}
