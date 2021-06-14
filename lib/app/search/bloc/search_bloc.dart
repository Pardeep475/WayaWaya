import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/search/model/global_app_search.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';

class SearchBloc {

  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
  StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;


// ignore: close_sinks
  final _noDataFoundController = StreamController<bool>();

  StreamSink<bool> get noDataFoundSink =>
      _noDataFoundController.sink;

  Stream<bool> get noDataFoundStream =>
      _noDataFoundController.stream;

  // ignore: close_sinks
  final _allSearchController = StreamController<List<GlobalAppSearch>>();

  StreamSink<List<GlobalAppSearch>> get allSearchSink =>
      _allSearchController.sink;

  Stream<List<GlobalAppSearch>> get allSearchStream =>
      _allSearchController.stream;

  // ignore: close_sinks
  final _offerController = StreamController<List<GlobalAppSearch>>();

  StreamSink<List<GlobalAppSearch>> get offerSink => _offerController.sink;

  Stream<List<GlobalAppSearch>> get offerStream => _offerController.stream;

  // ignore: close_sinks
  final _eventController = StreamController<List<GlobalAppSearch>>();

  StreamSink<List<GlobalAppSearch>> get eventSink => _eventController.sink;

  Stream<List<GlobalAppSearch>> get eventStream => _eventController.stream;

  // ignore: close_sinks
  final _shopController = StreamController<List<GlobalAppSearch>>();

  StreamSink<List<GlobalAppSearch>> get shopSink => _shopController.sink;

  Stream<List<GlobalAppSearch>> get shopStream => _shopController.stream;

  // ignore: close_sinks
  final _restaurantController = StreamController<List<GlobalAppSearch>>();

  StreamSink<List<GlobalAppSearch>> get restaurantSink =>
      _restaurantController.sink;

  Stream<List<GlobalAppSearch>> get restaurantStream =>
      _restaurantController.stream;

  List<GlobalAppSearch> _allSearchList;
  List<GlobalAppSearch> _offerSearchList;
  List<GlobalAppSearch> _eventSearchList;
  List<GlobalAppSearch> _shopSearchList;
  List<GlobalAppSearch> _restaurantSearchList;

  getSearchItems(String searchQuery) async {
    debugPrint('search_testing:-   $searchQuery');
    String defaultMall = await SessionManager.getDefaultMall();
    // all search query
    _allSearchList = await ProfileDatabaseHelper.getAllSearchType(
        databasePath: defaultMall, searchQuery: searchQuery);
    debugPrint('search_testing:-  _allSearchList   ${_allSearchList.length}');

    allSearchSink.add(_allSearchList);
  }

  getRestaurantSearchItems(String searchQuery) async {
    // event search query
    String defaultMall = await SessionManager.getDefaultMall();
    _restaurantSearchList = await ProfileDatabaseHelper.getRestaurantSearchType(
        databasePath: defaultMall, searchQuery: searchQuery);
    debugPrint(
        'search_testing:-  _restaurantSearchList   ${_restaurantSearchList.length}');
    restaurantSink.add(_restaurantSearchList);
  }

  getOfferSearchItems(String searchQuery) async {
    // event search query
    String defaultMall = await SessionManager.getDefaultMall();
    _offerSearchList = await ProfileDatabaseHelper.getOfferSearchType(
        databasePath: defaultMall, searchQuery: searchQuery);
    debugPrint(
        'search_testing:-  _offerSearchList   ${_offerSearchList.length}');
    offerSink.add(_offerSearchList);
  }

  getEventSearchItems(String searchQuery) async {
    // event search query
    String defaultMall = await SessionManager.getDefaultMall();
    _eventSearchList = await ProfileDatabaseHelper.getEventsSearchType(
        databasePath: defaultMall, searchQuery: searchQuery);
    debugPrint(
        'search_testing:-  _eventSearchList   ${_eventSearchList.length}');
    eventSink.add(_eventSearchList);
  }

  getShopSearchItems(String searchQuery) async {
    // shop search query
    String defaultMall = await SessionManager.getDefaultMall();
    _shopSearchList = await ProfileDatabaseHelper.getShopSearchType(
        databasePath: defaultMall, searchQuery: searchQuery);
    debugPrint('search_testing:-  _shopSearchList   ${_shopSearchList.length}');
    shopSink.add(_shopSearchList);
  }

  List<GlobalAppSearch> get allSearchList => _allSearchList;

  List<GlobalAppSearch> get offerSearchList => _offerSearchList;

  List<GlobalAppSearch> get eventSearchList => _eventSearchList;

  List<GlobalAppSearch> get shopSearchList => _shopSearchList;

  List<GlobalAppSearch> get restaurantSearchList => _restaurantSearchList;


  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
    await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    debugPrint('main_menu_permission_testing:--   ${itemList.length}');
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }

}
