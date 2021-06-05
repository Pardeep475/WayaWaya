import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/app/common/full_screen_privacy_policy_dialog.dart';
import 'package:wayawaya/app/settings/model/settings_model.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';

class SettingsBloc {
// ignore: close_sinks
  StreamController _settingsController =
      StreamController<List<SettingsModel>>();

  StreamSink<List<SettingsModel>> get settingsSink => _settingsController.sink;

  Stream<List<SettingsModel>> get settingsStream => _settingsController.stream;

  List<SettingsModel> _settingsItemList = [];

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
}
