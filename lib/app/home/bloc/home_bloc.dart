import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';

class HomeBloc {
  // ignore: close_sinks
  final _campaignController = StreamController<List<Campaign>>();

  StreamSink<List<Campaign>> get campaignSink => _campaignController.sink;

  Stream<List<Campaign>> get campaignStream => _campaignController.stream;

// ignore: close_sinks
  final _activityController = StreamController<List<String>>();

  StreamSink<List<String>> get activitySink => _activityController.sink;

  Stream<List<String>> get activityStream => _activityController.stream;

  List<Campaign> offersCampaignList = [];
  List<Campaign> eventsCampaignList = [];
  List<Campaign> whatsonCampaignList = [];
  List<String> activitiesCampaignList = [];

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
            offersCampaignList.add(element);
            break;
          }
        case AppString.EVENT_CAMPAIGN:
          {
            eventsCampaignList.add(element);
            break;
          }
        case AppString.WHATSON_CAMPAIGN:
          {
            whatsonCampaignList.add(element);
            break;
          }
        case AppString.ACTIVITIES_CAMPAIGN:
          {
            debugPrint(
                'home_screen_data_testing   :- activity ${element.campaignElement}');
            Map<String, dynamic> listActivity =
                jsonDecode(element.campaignElement);
            debugPrint(
                'home_screen_data_testing   :- activity 2 ${listActivity['image_id']}');
            List<dynamic> listImage = listActivity['image_id'];
            debugPrint('home_screen_data_testing   :- activity 3 ${listImage}');
            listImage.forEach((value) {
              if (value['language'] == 'en_US') {
                activitiesCampaignList.add(value['text']);
              }
              debugPrint('home_screen_data_testing   :- value  $value');
              debugPrint(
                  'home_screen_data_testing   :- value 2 ${value['text']}');
            });
            //
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
  }

  List<Campaign> get getOffers => offersCampaignList;

  List<Campaign> get getEvents => eventsCampaignList;

  List<Campaign> get getWhatsOn => whatsonCampaignList;

  List<String> get getActivity => activitiesCampaignList;
}
