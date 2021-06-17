import 'dart:async';

import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';

class EventBloc {
  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  // ignore: close_sinks
  final _eventCampaignController =
      StreamController<ApiResponse<List<Campaign>>>();

  StreamSink<ApiResponse<List<Campaign>>> get eventCampaignSink =>
      _eventCampaignController.sink;

  Stream<ApiResponse<List<Campaign>>> get eventCampaignStream =>
      _eventCampaignController.stream;

  getEventCampaign() async {
    eventCampaignSink.add(ApiResponse.loading(null));
    try {
      String defaultMall = await SessionManager.getDefaultMall();
      List<Campaign> campaignList =
          await ProfileDatabaseHelper.getCampaignByType(
              databasePath: defaultMall, campaignType: 'event');
      eventCampaignSink.add(ApiResponse.completed(campaignList));
    } catch (e) {
      eventCampaignSink.add(ApiResponse.error(e));
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
