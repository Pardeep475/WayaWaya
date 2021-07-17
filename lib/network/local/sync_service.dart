import 'package:flutter/material.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/network/model/campaign/campaign_api_response.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

import 'database_helper.dart';
import 'profile_database_helper.dart';

class SyncService {
  // make it singleton class
  static final SyncService _syncService = SyncService._internal();

  factory SyncService() {
    return _syncService;
  }

  SyncService._internal();

  static final _repository = ApiRepository();

  static String lastUpdate;

  static fetchAllSyncData() async {
    await setSyncDateQuery();
    // await fetchUpdateData(1);
    await fetchCampaignData(1);
  }

  static setSyncDateQuery() async {
    String syncDate = await SessionManager.getSyncDate();
    if (syncDate != null) {
      lastUpdate = syncDate;
    } else {
      lastUpdate =
          Utils.getStringFromDate(Utils.firstDate(), AppString.DATE_FORMAT);
    }
  }

  static fetchUpdateData(int page) {
    Utils.checkConnectivity().then((value) {
      if (value != null && value) {
        dynamic data = _repository.getSyncStatus(lastUpdate, page);
      }
    });
  }

  static fetchCampaignData(int page) async {
    int count = await DataBaseHelperCommon.getCampaignLength();
    debugPrint('CountOfCampaign:-  $count');
    // if (count == 0 || count < 0) {
    //   syncCampaignDataFromDatabase();
    // } else {
      Utils.checkConnectivity().then((value) {
        if (value != null && value) {
          syncCampaignDataFromNetwork(page);
        }
      });
    // }
  }

  static syncCampaignDataFromNetwork(int page) async {
    try {
      dynamic data = await _repository.fetchCampaignApiRepository(
          lastUpdate: lastUpdate, nextPage: page);
      if (data == null) {
        return;
      }
      if (data.data == null) {
        return;
      }
      CampaignApiResponse _campaignApiResponse =
          CampaignApiResponse.fromJson(data.data);
      if (_campaignApiResponse.items != null &&
          _campaignApiResponse.items.isNotEmpty) {
        debugPrint('campaign_count:-  ${_campaignApiResponse.items.length}');
        await Future.forEach(_campaignApiResponse.items,
            (Campaign element) async {
          debugPrint('CampaignId:-  ${element.id}');
          await DataBaseHelperCommon.insertCampaign(
              element.toJson(), element.id);
        });
      }
      if (_campaignApiResponse.links != null &&
          _campaignApiResponse.links.next != null) {
        syncCampaignDataFromNetwork(page + 1);
      }
    } catch (e) {
      debugPrint('campaign_exception:- $e');
    }
  }

  static syncCampaignDataFromDatabase() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<Campaign> campaignList =
        await ProfileDatabaseHelper.getLauncherCampaignData(
            databasePath: defaultMall,
            limit: 25,
            offset: 0,
            rid: "",
            searchText: "",
            publish_date:
                Utils.getStringFromDate(DateTime.now(), AppString.DATE_FORMAT),
            campaignType: "");

    campaignList.forEach((element) async {
      debugPrint('CampaignId:-  ${element.id}');
      await DataBaseHelperCommon.insertCampaign(element.toJson(), element.id);
    });

    int count = await DataBaseHelperCommon.getCampaignLength();
    debugPrint('CountOfCampaign:-  $count');
  }
}
