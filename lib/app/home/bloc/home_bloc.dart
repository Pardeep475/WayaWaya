import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/home/model/campaign_element.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/home/model/top_campaign_model.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';

class HomeBloc {

  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
  StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  // ignore: close_sinks
  final _campaignController = StreamController<List<Campaign>>();

  StreamSink<List<Campaign>> get campaignSink => _campaignController.sink;

  Stream<List<Campaign>> get campaignStream => _campaignController.stream;

// ignore: close_sinks
  final _activityController = StreamController<List<String>>();

  StreamSink<List<String>> get activitySink => _activityController.sink;

  Stream<List<String>> get activityStream => _activityController.stream;

  // ignore: close_sinks
  final _topCampaignController = StreamController<List<TopCampaignModel>>();

  StreamSink<List<TopCampaignModel>> get topSink => _topCampaignController.sink;

  Stream<List<TopCampaignModel>> get topStream => _topCampaignController.stream;

  List<Campaign> offersCampaignList = [];
  List<Campaign> eventsCampaignList = [];
  List<Campaign> whatsonCampaignList = [];
  List<String> activitiesCampaignList = [];

  List<TopCampaignModel> topCampaignList = [];

  getAllCampaign() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<Campaign> campaignList =
        await ProfileDatabaseHelper.getAllCampaign(defaultMall);

    if (campaignList.isNotEmpty) {
      debugPrint(
          'campaignList:-  ${campaignList.length}   ${campaignList[0].offerQrCode}');

      _differnicateCatagories(campaignList);

      campaignSink.add(campaignList);
    }
  }

  _differnicateCatagories(List<Campaign> campaignList) {
    campaignList.forEach((element) {
      switch (element.type) {
        case AppString.OFFER_CAMPAIGN:
          {
            CampaignElement campaignElement =
                CampaignElement.fromJson(jsonDecode(element.campaignElement));
            campaignElement.imageId.forEach((element) {
              // ignore: unrelated_type_equality_checks
              if (element.language == Language.EN_US) {
                debugPrint(
                    'home_screen_data_testing   :- OFFER_CAMPAIGN ${element.text}');
                topCampaignList.add(TopCampaignModel(
                    imgUrl: element.text, tag: AppString.offer));
              }
            });

            break;
          }
        case AppString.EVENT_CAMPAIGN:
          {
            CampaignElement campaignElement =
                CampaignElement.fromJson(jsonDecode(element.campaignElement));
            campaignElement.imageId.forEach((element) {
              // ignore: unrelated_type_equality_checks
              if (element.language == Language.EN_US) {
                debugPrint(
                    'home_screen_data_testing   :- EVENT_CAMPAIGN ${element.text}');
                topCampaignList.add(TopCampaignModel(
                    imgUrl: element.text, tag: AppString.event));
              }
            });

            break;
          }
        case AppString.WHATSON_CAMPAIGN:
          {
            whatsonCampaignList.add(element);
            break;
          }
        case AppString.ACTIVITIES_CAMPAIGN:
          {
            CampaignElement campaignElement =
                CampaignElement.fromJson(jsonDecode(element.campaignElement));
            campaignElement.imageId.forEach((element) {
              // ignore: unrelated_type_equality_checks
              if (element.language == Language.EN_US) {
                activitiesCampaignList.add(element.text);
              }
            });
            break;
          }
      }
    });

    debugPrint(
        'home_screen_data_testing   :- offersCampaignList ${offersCampaignList.length}');
    debugPrint(
        'home_screen_data_testing   :- eventsCampaignList ${eventsCampaignList.length}');
    debugPrint(
        'home_screen_data_testing   :- whatsonCampaignList ${whatsonCampaignList.length}');
    debugPrint(
        'home_screen_data_testing   :- activitiesCampaignList ${activitiesCampaignList.length}');

    activitySink.add(activitiesCampaignList);
    topSink.add(topCampaignList);
  }

  List<Campaign> get getOffers => offersCampaignList;

  List<Campaign> get getEvents => eventsCampaignList;

  List<Campaign> get getWhatsOn => whatsonCampaignList;

  List<String> get getActivity => activitiesCampaignList;


  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
    await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    debugPrint('main_menu_permission_testing:--   ${itemList.length}');
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }

}
