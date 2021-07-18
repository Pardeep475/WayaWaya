import 'dart:async';

import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/network/local/database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class OffersBloc {
  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  // ignore: close_sinks
  final _offerCampaignController =
      StreamController<ApiResponse<List<Campaign>>>();

  StreamSink<ApiResponse<List<Campaign>>> get offerCampaignSink =>
      _offerCampaignController.sink;

  Stream<ApiResponse<List<Campaign>>> get offerCampaignStream =>
      _offerCampaignController.stream;

  getOfferCampaign({String rid}) async {
    offerCampaignSink.add(ApiResponse.loading(null));
    try {
      // String defaultMall = await SessionManager.getDefaultMall();
      // List<Campaign> campaignList =
      //     await ProfileDatabaseHelper.getCampaignByType(
      //         databasePath: defaultMall, campaignType: 'offer',rid: rid);

      List<Campaign> campaignList =
          await DataBaseHelperCommon.getCampaignOffersAndEvents(
              limit: 25,
              offset: 0,
              rid: rid ?? "",
              searchText: "",
              publish_date: Utils.getStringFromDate(
                  DateTime.now(), AppString.DATE_FORMAT),
              isCoupon: false,
              campaingType: "offer");

      offerCampaignSink.add(ApiResponse.completed(campaignList));
    } catch (e) {
      offerCampaignSink.add(ApiResponse.error(e));
    }
  }

  fetchMenuButtons() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<MainMenuPermission> itemList =
        await SuperAdminDatabaseHelper.getMenuButtons(defaultMall);
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }
}
