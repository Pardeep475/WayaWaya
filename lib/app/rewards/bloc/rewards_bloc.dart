import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/rewards/model/rewards_categories.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/network/local/database_helper.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class RewardsBloc {
  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

// ignore: close_sinks
  StreamController _rewardsCategoryController =
      StreamController<List<RewardsCategory>>();

  StreamSink<List<RewardsCategory>> get rewardsCategorySink =>
      _rewardsCategoryController.sink;

  Stream<List<RewardsCategory>> get rewardsCategoryStream =>
      _rewardsCategoryController.stream;

  // ignore: close_sinks
  StreamController _rewardsListController =
      StreamController<ApiResponse<List<Campaign>>>();

  StreamSink<ApiResponse<List<Campaign>>> get rewardsListSink =>
      _rewardsListController.sink;

  Stream<ApiResponse<List<Campaign>>> get rewardsListStream =>
      _rewardsListController.stream;

  // ignore: close_sinks
  StreamController _titleRewardsCategoryController = StreamController<String>();

  StreamSink<String> get titleRewardsCategorySink =>
      _titleRewardsCategoryController.sink;

  Stream<String> get titleRewardsCategoryStream =>
      _titleRewardsCategoryController.stream;

  List<RewardsCategory> _rewardsCategoryList;

  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
        await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }

  fetchRewardsCategory() async {
    String defaultMall = await SessionManager.getDefaultMall();
    _rewardsCategoryList = await ProfileDatabaseHelper.getRewardsCategories(
      databasePath: defaultMall,
    );
    RewardsCategory _rewardsCategory =
        RewardsCategory(name: "All", isSelected: true);
    _rewardsCategoryList.add(_rewardsCategory);
    rewardsCategorySink.add(_rewardsCategoryList);
  }

  updateRewardsCategory(int index) {
    for (int i = 0; i < _rewardsCategoryList.length; i++) {
      if (i == index) {
        _rewardsCategoryList[i].isSelected = true;
      } else {
        _rewardsCategoryList[i].isSelected = false;
      }
    }
    rewardsCategorySink.add(_rewardsCategoryList);
  }

  fetchRewardsList() async {
    rewardsListSink.add(ApiResponse.loading(null));
    try {
      List<Campaign> campaignList =
          await DataBaseHelperCommon.getRewardsCampaignData(
              limit: 25,
              offset: 0,
              rid: "",
              searchText: "",
              categoryId: "",
              publish_date: Utils.getStringFromDate(
                  DateTime.now(), AppString.DATE_FORMAT),
              campaingType: "offer");

      rewardsListSink.add(ApiResponse.completed(campaignList));
    } catch (e) {
      rewardsListSink.add(ApiResponse.error(e));
    }
  }

  fetchRewardsListByCategory(String categoryId) async {
    debugPrint('categoryID:-   $categoryId');
    rewardsListSink.add(ApiResponse.loading(null));
    try {
      List<Campaign> campaignList =
          await DataBaseHelperCommon.getRewardsCampaignData(
              limit: 25,
              offset: 0,
              rid: "",
              searchText: "",
              categoryId: categoryId ?? "",
              publish_date: Utils.getStringFromDate(
                  DateTime.now(), AppString.DATE_FORMAT),
              campaingType: "offer");

      debugPrint('list_of_categories:-   ${campaignList.length}');

      rewardsListSink.add(ApiResponse.completed(campaignList));
    } catch (e) {
      rewardsListSink.add(ApiResponse.error(e));
    }
  }
}
