import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wayawaya/app/preferences/model/currency_model.dart';
import 'package:wayawaya/app/preferences/model/language_model.dart';
import 'package:wayawaya/app/preferences/model/notification_model.dart';
import 'package:wayawaya/common/model/language_store.dart';
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class SelectPreferencesBloc {
  List<DropdownMenuItem<NotificationModel>> items = [];

// ignore: close_sinks
  StreamController _mallProfileController =
      StreamController<List<MallProfileModel>>();

  StreamSink<List<MallProfileModel>> get mallProfileSink =>
      _mallProfileController.sink;

  Stream<List<MallProfileModel>> get mallProfileStream =>
      _mallProfileController.stream;

  // ignore: close_sinks
  StreamController _notificationController =
      StreamController<NotificationModel>();

  StreamSink<NotificationModel> get notificationSink =>
      _notificationController.sink;

  Stream<NotificationModel> get notificationStream =>
      _notificationController.stream;

  // ignore: close_sinks
  StreamController _currencyController =
      StreamController<List<CurrencyModel>>();

  StreamSink<List<CurrencyModel>> get currencySink => _currencyController.sink;

  Stream<List<CurrencyModel>> get currencyStream => _currencyController.stream;

  // ignore: close_sinks
  StreamController _languageController =
      StreamController<List<LanguageModel>>();

  StreamSink<List<LanguageModel>> get languageSink => _languageController.sink;

  Stream<List<LanguageModel>> get languageStream => _languageController.stream;

  List<MallProfileModel> _allMallList = [];

  getMallData() async {
    List<MallProfileModel> _mallList =
        await SuperAdminDatabaseHelper.getAllVenueProfile();
    debugPrint('database_testing:-   ${_mallList.length}');
    _allMallList.addAll(_mallList);

    String key = await SessionManager.getDefaultMall();
    bool isSelected = false;
    for (int i = 0; i < _allMallList.length; i++) {
      if (key == _allMallList[i].identifier) {
        isSelected = true;
        updateItemMallList(i, _allMallList[i], true);
        return;
      }
    }

    if (!isSelected) {
      updateItemMallList(0, _allMallList[0], true);
    }

    debugPrint('Mall_profile_updated_successfully');
    // mallProfileSink.add(_mallList);
  }

  getNotificationData(BuildContext context) async {
    dynamic mallData = await SessionManager.getSmallDefaultMallData();
    dynamic value = json.decode(mallData);
    List<NotificationModel> notificationList = _getNotification(context, value);
    debugPrint('notification_list_testing:-  ${notificationList.toString()}');
    _buildDropDownMenuItems(notificationList);
    notificationList.forEach((element) {
      if (element.local) {
        debugPrint('notification_list_testing:-  ${element.title}');
        notificationSink.add(element);
        return;
      }
    });
    _getCurrency(value);
    _getLanguageCode(value);
  }

  List<NotificationModel> _getNotification(
      BuildContext context, dynamic mallData) {
    List<NotificationModel> finalNotificationList = [];
    try {
      List _notificationList = mallData['notification_list'];
      _notificationList.forEach((element) {
        List _languageStoreList = element['notification_label'];
        List<LanguageStore> _finalList = [];
        _languageStoreList.forEach((element) {
          LanguageStore _languageStore = LanguageStore.fromJson(element);
          _finalList.add(_languageStore);
        });
        finalNotificationList.add(
          NotificationModel(
            title: Utils.getTranslatedCode(context, _finalList),
            local: element['local'],
          ),
        );
        // if (element['local'] == true)
      });
      return finalNotificationList;
    } catch (e) {
      debugPrint('notification_list_testing:-  $e');
    }

    if (finalNotificationList.length == 0) {
      finalNotificationList
          .add(NotificationModel(title: "12 daily", local: true));
    }

    return finalNotificationList;
  }

  _buildDropDownMenuItems(List<NotificationModel> _notifications) {
    for (NotificationModel notification in _notifications) {
      items.add(
        DropdownMenuItem(
          value: notification,
          child: Text(
            notification.title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
  }

  List<DropdownMenuItem<NotificationModel>> get getDropDownItems => items;

  _getLanguageCode(dynamic mallData) {
    List<LanguageModel> _languageModelList = [];
    try {
      List _languageList = mallData['language_list'];
      _languageList.forEach((element) {
        _languageModelList.add(
          LanguageModel(
            code: element['code'],
            name: element['name'],
            local: element['local'],
          ),
        );
      });
      // return '${mallData['currency_list'][0]['code']}, ${mallData['currency_list'][0]['country_code']}';
    } catch (e) {
      debugPrint('language_model_testing:-  $e');
    }
    languageSink.add(_languageModelList);
  }

  _getCurrency(dynamic mallData) {
    List<CurrencyModel> _currencyModelList = [];
    try {
      List _currencyList = mallData['currency_list'];
      _currencyList.forEach((element) {
        _currencyModelList.add(
          CurrencyModel(
            code: element['code'],
            countryCode: element['country_code'],
            local: element['local'],
          ),
        );
      });
      // return '${mallData['currency_list'][0]['code']}, ${mallData['currency_list'][0]['country_code']}';
    } catch (e) {
      debugPrint('currency_model_testing:-  $e');
    }
    currencySink.add(_currencyModelList);
  }

  updateItemMallList(
      int position, MallProfileModel mallProfileModel, bool selected) {
    mallProfileModel.active = selected ? 0 : 1;
    List<MallProfileModel> mallList = [];
    for (int i = 0; i < _allMallList.length; i++) {
      if (position == i) {
        MallProfileModel _mallProfileModel = _allMallList[i];
        _mallProfileModel.active = selected ? 0 : 1;
        debugPrint(
            'updated_mall_data_testing:-  index  $i  active  ${_mallProfileModel.active}  selected:-  $selected');
        mallList.add(_mallProfileModel);
      } else {
        MallProfileModel _mallProfileModel = _allMallList[i];
        _mallProfileModel.active = 1;
        mallList.add(_mallProfileModel);
      }
    }
    _allMallList = [];
    _allMallList.addAll(mallList);
    mallProfileSink.add(_allMallList);
  }
}
