import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/home/model/campaign_element.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/home/model/top_campaign_model.dart';
import 'package:wayawaya/app/home/model/whatson_campaign.dart';
import 'package:wayawaya/common/model/language_store.dart';
import 'package:wayawaya/network/local/database_helper.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

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
  final _topCampaignController = StreamController<WhatsonCampaign>();

  StreamSink<WhatsonCampaign> get topSink => _topCampaignController.sink;

  Stream<WhatsonCampaign> get topStream => _topCampaignController.stream;

  List<Campaign> offersCampaignList = [];
  List<Campaign> eventsCampaignList = [];
  List<String> whatsonCampaignList = [];
  List<String> activitiesCampaignList = [];

  List<TopCampaignModel> topCampaignList = [];

  getAllCampaign(BuildContext context) async {
    Utils.commonProgressDialog(context);

    getCampaignData().then((value) {
      Navigator.pop(context);
      _differnicateCatagories(value);
      campaignSink.add(value);
    });
  }

  Future<List<Campaign>> getCampaignData() async {
    List<Campaign> campaignList =
        await DataBaseHelperCommon.getLauncherCampaignData(
            limit: 25,
            offset: 0,
            rid: "",
            searchText: "",
            publish_date:
                Utils.getStringFromDate(DateTime.now(), AppString.DATE_FORMAT),
            campaignType: "");

    if (campaignList.isEmpty) {
      Future.delayed(Duration(microseconds: 500), () {
        getCampaignData();
      });
    }
    return campaignList;
  }

  _differnicateCatagories(List<Campaign> campaignList) {
    campaignList.forEach((element) {
      switch (element.type) {
        case AppString.OFFER_CAMPAIGN:
          {
            CampaignElement campaignElement;
            try {
              campaignElement =
                  CampaignElement.fromJson(jsonDecode(element.campaignElement));
            } catch (e) {
              campaignElement = CampaignElement.fromJson(
                  jsonDecode(jsonDecode(element.campaignElement)));
            }

            try {
              List<LanguageStore> imageId = List<LanguageStore>.from(
                  campaignElement.imageId
                      .map((x) => LanguageStore.fromJson(x)));
              imageId.forEach((campaignModel) {
                // ignore: unrelated_type_equality_checks
                if (campaignModel.language == 'en_US') {
                  topCampaignList.add(TopCampaignModel(
                      imgUrl: campaignModel.text,
                      tag: AppString.offer,
                      campaign: element));
                }
              });
            } catch (e) {}

            break;
          }
        case AppString.EVENT_CAMPAIGN:
          {
            CampaignElement campaignElement;
            try {
              campaignElement =
                  CampaignElement.fromJson(jsonDecode(element.campaignElement));
            } catch (e) {
              campaignElement = CampaignElement.fromJson(
                  jsonDecode(jsonDecode(element.campaignElement)));
            }

            try {
              List<LanguageStore> imageId = List<LanguageStore>.from(
                  campaignElement.imageId
                      .map((x) => LanguageStore.fromJson(x)));
              imageId.forEach((campaignModel) {
                // ignore: unrelated_type_equality_checks
                if (campaignModel.language == 'en_US') {
                  topCampaignList.add(TopCampaignModel(
                      imgUrl: campaignModel.text,
                      tag: AppString.event,
                      campaign: element));
                }
              });
            } catch (e) {
              debugPrint('database_exception:-  $e');
            }
            break;
          }
        case AppString.WHATSON_CAMPAIGN:
          {
            CampaignElement campaignElement;
            try {
              campaignElement =
                  CampaignElement.fromJson(jsonDecode(element.campaignElement));
            } catch (e) {
              campaignElement = CampaignElement.fromJson(
                  jsonDecode(jsonDecode(element.campaignElement)));
            }

            try {
              List<LanguageStore> imageId = List<LanguageStore>.from(
                  campaignElement.imageId
                      .map((x) => LanguageStore.fromJson(x)));
              imageId.forEach((element) {
                // ignore: unrelated_type_equality_checks
                if (element.language == 'en_US') {
                  whatsonCampaignList.add(element.text);
                }
              });
            } catch (e) {
              debugPrint('database_exception:-  $e');
            }

            break;
          }
        case AppString.ACTIVITIES_CAMPAIGN:
          {
            CampaignElement campaignElement;
            try {
              campaignElement =
                  CampaignElement.fromJson(jsonDecode(element.campaignElement));
            } catch (e) {
              campaignElement = CampaignElement.fromJson(
                  jsonDecode(jsonDecode(element.campaignElement)));
            }

            try {
              List<LanguageStore> imageId = List<LanguageStore>.from(
                  campaignElement.imageId
                      .map((x) => LanguageStore.fromJson(x)));
              imageId.forEach((element) {
                // ignore: unrelated_type_equality_checks
                if (element.language == 'en_US') {
                  activitiesCampaignList.add(element.text);
                }
              });
            } catch (e) {
              debugPrint('database_exception:-  $e');
            }
            break;
          }
      }
    });

    activitySink.add(activitiesCampaignList);
    WhatsonCampaign _whatsonCampaign = WhatsonCampaign(
        itemList: topCampaignList, whatsonList: whatsonCampaignList);
    topSink.add(_whatsonCampaign);
  }

  List<Campaign> get getOffers => offersCampaignList;

  List<Campaign> get getEvents => eventsCampaignList;

  List<String> get getWhatsOn => whatsonCampaignList;

  List<String> get getActivity => activitiesCampaignList;

  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
        await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }
}
