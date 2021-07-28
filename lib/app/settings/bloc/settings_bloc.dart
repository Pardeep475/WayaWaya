import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/app/common/full_screen_privacy_policy_dialog.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/settings/model/settings_model.dart';
import 'package:wayawaya/models/omni_channel_item_model/omni_channel_item_model.dart';
import 'package:wayawaya/models/retail_unit/retail_unit_wrapper.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/network/local/database_helper.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/network/local/sync_service.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class SettingsBloc {
// ignore: close_sinks
  StreamController _settingsController =
      StreamController<List<SettingsModel>>();

  StreamSink<List<SettingsModel>> get settingsSink => _settingsController.sink;

  Stream<List<SettingsModel>> get settingsStream => _settingsController.stream;

  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  List<SettingsModel> _settingsItemList = [];

  final _repository = ApiRepository();

  setUpSettingsData() {
    _settingsItemList.add(
        SettingsModel(icon: Icons.account_box, title: AppString.my_account));
    _settingsItemList.add(SettingsModel(
        icon: FontAwesomeIcons.slidersH, title: AppString.preferences_small));
    _settingsItemList.add(
        SettingsModel(icon: Icons.phone_android, title: AppString.my_devices));
    _settingsItemList.add(
        SettingsModel(icon: Icons.thumb_up, title: AppString.my_favourites));
    _settingsItemList
        .add(SettingsModel(icon: null, title: AppString.privacy_policy));
    _settingsItemList
        .add(SettingsModel(icon: null, title: AppString.term_and_conditions));

    settingsSink.add(_settingsItemList);
  }

  List<SettingsModel> get getSettingsData => _settingsItemList;

  termAndConditionOnClick(BuildContext context) async {
    debugPrint('Term and condition');
    dynamic mallData = await SessionManager.getSmallDefaultMallData();
    dynamic value = json.decode(mallData);
    dynamic tAcUrl = value['terms_and_conditions_url'][0]['text'];
    // String termAndCondition =
    //     new Uri.dataFromString(tAcUrl, mimeType: 'text/html').toString();
    Navigator.push(
      context,
      FullScreenPrivacyPolicyDialog(
          title: AppString.term_and_conditions, url: tAcUrl),
    ).then((value) {});
  }

  privacyPolicyOnClick(BuildContext context) {
    debugPrint('privacy_policy_url:---->   error');
    Navigator.push(
      context,
      FullScreenPrivacyPolicyDialog(
          title: AppString.privacy_policy, url: AppString.PRIVACY_POLICY_URL),
    ).then((value) {});
  }

  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
        await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }

  syncCampaign(int page) async {
    List<Campaign> campaignList =
        await DataBaseHelperCommon.getLauncherCampaignData(
            limit: 25,
            offset: 0,
            rid: "",
            searchText: "",
            publish_date:
                Utils.getStringFromDate(DateTime.now(), AppString.DATE_FORMAT),
            campaignType: "");

    debugPrint('campaignList:-   ${campaignList.length}');

    //

    // await SyncService.fetchLoyaltyFromNetwork(0);

    // String defaultMall = await SessionManager.getDefaultMall();
    // OmniChannelItemModel _omniChannelItemModel =
    //     await ProfileDatabaseHelper.getActiveOmniChannel(
    //   databasePath: defaultMall,
    // );
    // debugPrint("omni_channel_item_model :-       ${_omniChannelItemModel.oid}");
    // //
    // String authorization = await SessionManager.getAuthHeader();
    // String lastUpdate = '2020-07-02 01:01:11';
    //
    // Map<String, dynamic> campaignQuery = {
    //   "page": page.toString(),
    //   "sort": "-_updated",
    //   "enable": true,
    //   "where":
    //       "{\"campaign_channels.omni_channel_id\":{\"\$elemMatch\":{\"\$eq\":\"" +
    //           _omniChannelItemModel.oid +
    //           "\"}}}",
    // };
    // // Map<String, String> campaignQuery = {
    // //   "page": page.toString(),
    // //   "sort": "-_updated",
    // //   "where": "{\"_updated\":{\"\$gt\": \"" + lastUpdate + "\"}}",
    // // };
    //
    // debugPrint("campaignQuery :-       $campaignQuery");
    //
    // try {
    //   dynamic data = await _repository.fetchCampaignApiRepository(
    //       authorization: authorization, map: campaignQuery);
    //   // dynamic data = await _repository.fetchCampaignApiRepository(authorization: authorization);
    //   debugPrint("campaign_settings:-  success $data");
    //
    //   // RetailUnitWrapper _retailUnitWrapper = RetailUnitWrapper.fromJson(data.data);
    //   // debugPrint("campaign_settings:-  success ${_retailUnitWrapper.items.length}");
    //
    // } catch (e) {
    //   debugPrint('error_settings:-    $e');
    // }
    //
    // // if (campaignIds != null) {
    //
    // // campaignQuery.put("_id", "{\"$in\":" + String.valueOf(campaignIds) + "}");
    //
    // // }
  }
}
