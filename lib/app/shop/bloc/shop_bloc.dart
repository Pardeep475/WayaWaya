import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/shop/model/category_based_model.dart';
import 'package:wayawaya/app/shop/model/retail_unit_category.dart';
import 'package:wayawaya/app/shop/model/retail_with_category.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

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

  // ignore: close_sinks
  StreamController _orderListingController =
      StreamController<List<RetailWithCategory>>();

  StreamSink<List<RetailWithCategory>> get orderListingSink =>
      _orderListingController.sink;

  Stream<List<RetailWithCategory>> get orderListingStream =>
      _orderListingController.stream;

  // ignore: close_sinks
  StreamController _categoryBasedController =
      StreamController<List<CategoryBasedModel>>();

  StreamSink<List<CategoryBasedModel>> get categoryBasedSink =>
      _categoryBasedController.sink;

  Stream<List<CategoryBasedModel>> get categoryBasedStream =>
      _categoryBasedController.stream;

  // ignore: close_sinks
  StreamController _favouriteListingController =
      StreamController<List<RetailWithCategory>>();

  StreamSink<List<RetailWithCategory>> get favouriteListingSink =>
      _favouriteListingController.sink;

  Stream<List<RetailWithCategory>> get favouriteListingStream =>
      _favouriteListingController.stream;

  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
        await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    debugPrint('main_menu_permission_testing:--   ${itemList.length}');
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }

  fetchOrderedCategoryListing({bool isRestaurant}) async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<RetailWithCategory> _retailWithCategoryList =
        await ProfileDatabaseHelper.getRetailWithCategory(
            databasePath: defaultMall,
            isShop: isRestaurant,
            searchQuery: '',
            categoryId: '',
            favourite: 0);

    orderListingSink.add(_retailWithCategoryList);
  }

  fetchCategoryBasedListing({bool isRestaurant}) async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<RetailUnitCategory> _retailUnitCategoryList =
        await ProfileDatabaseHelper.getRestaurantAndStopData(
      databasePath: defaultMall,
      isShop: isRestaurant,
      searchQuery: '',
    );
    List<CategoryBasedModel> _categoryBasedModelList = [];

    try {
      await Future.forEach(_retailUnitCategoryList,
          (RetailUnitCategory categoryName) async {
        String title = _getCategoryName(categoryName.name);
        if (categoryName.categoryId != null && categoryName.categoryId != '') {
          List<RetailWithCategory> _retailWithCategoryList =
              await ProfileDatabaseHelper.getRetailWithCategory(
                  databasePath: defaultMall,
                  isShop: isRestaurant,
                  searchQuery: '',
                  categoryId: categoryName.categoryId,
                  favourite: 0);
          if (title != null &&
              title != '' &&
              _retailWithCategoryList.isNotEmpty) {
            CategoryBasedModel _categoryBasedModel = CategoryBasedModel();
            _categoryBasedModel.title = title;
            _categoryBasedModel.retailWithCategory = _retailWithCategoryList;
            debugPrint(
                'check_categories_color:-   ${categoryName.categoryColor.hexCode}');
            if (categoryName.categoryColor != null &&
                categoryName.categoryColor.hexCode != null &&
                categoryName.categoryColor.hexCode.isNotEmpty) {
              _categoryBasedModel.categoryColor =
                  Utils.fromHex(categoryName.categoryColor.hexCode);
            } else {
              _categoryBasedModel.categoryColor = Colors.orange;
            }
            _categoryBasedModelList.add(_categoryBasedModel);
          }
        }
      });
      categoryBasedSink.add(_categoryBasedModelList);
    } catch (e) {
      debugPrint('check_categories_color:- error  $e');
      categoryBasedSink.add(_categoryBasedModelList);
    }

    debugPrint(
        'check_category_list_length:-   ${_categoryBasedModelList.length}');
  }

  String _getCategoryName(String categoryName) {
    List<String> listCategoryName = categoryName.split("<>");
    return listCategoryName[listCategoryName.length - 1];
  }

  fetchFavouriteListing({bool isRestaurant}) async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<RetailWithCategory> _retailWithCategoryList =
        await ProfileDatabaseHelper.getRetailWithCategory(
            databasePath: defaultMall,
            isShop: isRestaurant,
            searchQuery: '',
            categoryId: '',
            favourite: 1);

    favouriteListingSink.add(_retailWithCategoryList);
  }
}
