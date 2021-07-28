import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/forgotpassword/model/error_response.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/preferences/model/category_model.dart';
import 'package:wayawaya/app/preferences/model/currency_model.dart';
import 'package:wayawaya/app/preferences/model/language_model.dart';
import 'package:wayawaya/app/preferences/model/notification_model.dart';
import 'package:wayawaya/app/preferences/model/preferences_categories.dart';
import 'package:wayawaya/app/preferences/model/upload_preferences_model.dart';
import 'package:wayawaya/common/model/language_store.dart';
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/network/live/exception_handling/exception_handling.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

// language, currency
class SelectPreferencesBloc {
  List<DropdownMenuItem<NotificationModel>> items = [];

  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  // ignore: close_sinks
  StreamController _selectPreferencesController =
      StreamController<ApiResponse<ErrorResponse>>();

  StreamSink<ApiResponse<ErrorResponse>> get selectPreferencesSink =>
      _selectPreferencesController.sink;

  Stream<ApiResponse<ErrorResponse>> get selectPreferencesStream =>
      _selectPreferencesController.stream;

// ignore: close_sinks
  StreamController _mallProfileController =
      StreamController<List<MallProfileModel>>();

  StreamSink<List<MallProfileModel>> get mallProfileSink =>
      _mallProfileController.sink;

  Stream<List<MallProfileModel>> get mallProfileStream =>
      _mallProfileController.stream;

  // ignore: close_sinks
  StreamController _categoriesController =
      StreamController<List<CategoryModel>>();

  StreamSink<List<CategoryModel>> get categoriesSink =>
      _categoriesController.sink;

  Stream<List<CategoryModel>> get categoriesStream =>
      _categoriesController.stream;

  // ignore: close_sinks
  StreamController _notificationController =
      StreamController<NotificationModel>();

  StreamSink<NotificationModel> get notificationSink =>
      _notificationController.sink;

  Stream<NotificationModel> get notificationStream =>
      _notificationController.stream;

// ignore: close_sinks
  StreamController _languageCheckBoxController = StreamController<bool>();

  StreamSink<bool> get languageCheckBoxSink => _languageCheckBoxController.sink;

  Stream<bool> get languageCheckBoxStream => _languageCheckBoxController.stream;

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
  List<String> _categoriesList = [];

  String _selectedCurrency = '';
  String _selectedLanguage = '';
  String _favoriteMall = '';

  final _repository = ApiRepository();
  UserDataResponse _response;

  getMallData() async {
    String userData = await SessionManager.getUserData();
    if (userData != null) {
      _response = userDataResponseFromJson(userData);
    }

    List<MallProfileModel> _mallList =
        await SuperAdminDatabaseHelper.getAllVenueProfile();

    _allMallList.addAll(_mallList);

    if (_response == null) {
      String key = await SessionManager.getDefaultMall();
      _favoriteMall = key;
    } else {
      _favoriteMall = _response.favouriteMall;
    }

    debugPrint('favorite_mall_testing:-   $_favoriteMall');
    bool isSelected = false;
    for (int i = 0; i < _allMallList.length; i++) {
      if (_response == null) {
        updateItemMallList(i, _allMallList[i], i == 0 ? true : false);
        return;
      } else {
        if (_response.favouriteMall == _allMallList[i].identifier) {
          isSelected = true;
          updateItemMallList(i, _allMallList[i], true);
          return;
        }
      }
    }
    if (!isSelected) {
      updateItemMallList(0, _allMallList[0], true);
    }
  }

  getNotificationData(BuildContext context) async {
    dynamic mallData = await SessionManager.getSmallDefaultMallData();
    dynamic value = json.decode(mallData);
    List<NotificationModel> notificationList = _getNotification(context, value);
    debugPrint('notification_list_testing:-  ${notificationList.toString()}');
    _buildDropDownMenuItems(notificationList);

    if (_response == null) {
      notificationList.forEach((element) {
        if (element.local) {
          debugPrint('notification_list_testing:-  ${element.title}');
          notificationSink.add(element);
          return;
        }
      });
    } else {
      notificationList.forEach((element) {
        if (element.title.contains(_response.notification)) {
          notificationSink.add(element);
        }
      });
    }

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
    _favoriteMall = mallProfileModel.identifier;
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

  // categories implemented
  getPreferencesCategories() async {
    try {
      String defaultMall = await SessionManager.getDefaultMall();
      // String categories = await SessionManager.getGuestUserCategory();
      List<PreferencesCategory> categoriesList =
          await ProfileDatabaseHelper.getPreferencesCategories(
              defaultMall, "10000", "10000");

      if (_response != null) {
        debugPrint('preference_categories: -    ${_response.categories}');
        if (_response.categories != null) {
          debugPrint(
              'preference_categories: -  response.categories  ${_response.categories}');
          _response.categories.forEach((element) {
            debugPrint('preference_categories: -    $element');
            _categoriesList.add(element as String);
          });

          debugPrint(
              'preference_categories:- _intrestedCategories   ${_categoriesList.length}');
        }
      }

      List<CategoryModel> _finalList = [];
      bool isLogin = await SessionManager.isLogin();
      categoriesList.forEach((element) {
        String categoryName = element.name.replaceAll('<>', '/');
        String categoryId = element.categoryId;
        bool isSelected = isLogin != null && isLogin
            ? _categoriesList.contains(categoryId)
            : true;

        debugPrint(
            'preference_categories:-  CategoryName:-   $categoryName    CategoryId:-  $categoryId     IsSelected:-    $isSelected');

        CategoryModel categoryModel = CategoryModel(
            categoryId: categoryId,
            categoryName: categoryName,
            isSelected: isSelected);

        _finalList.add(categoryModel);
      });

      categoriesSink.add(_finalList);
    } catch (e) {
      debugPrint('database_testing:-  $e');
    }
  }

// save data localy without login
  Future putOfflineUserPreferenceData(
      int notify, String favMall, String curr, String lang) async {
    SessionManager.setGuestUserCategory(jsonEncode(_categoriesList));
    SessionManager.setGuestUserNotification(notify);
    SessionManager.setGuestUserFavouriteMall(favMall);
    SessionManager.setGuestUserCurrency(curr);
    SessionManager.setGuestUserLanguage(lang);
    return null;
  }

  List<String> get categoriesList => _categoriesList;

// add and remove data when switch on and off categories
  updateCategoriesList(String categoryId) {
    bool hasData = _categoriesList.contains(categoryId);
    debugPrint('preference_categories:-   hasData   $hasData');
    if (hasData) {
      _categoriesList.remove(categoryId);
    } else {
      _categoriesList.add(categoryId);
    }
  }

  // update currency
  updateCurrentCurrency(String currency) {
    _selectedCurrency = currency;
  }

  String get selectedCurrency => _selectedCurrency;

// update language
  updateCurrentLanguage(String language) {
    debugPrint('updateCurrentLanguage :-  $language');
    _selectedLanguage = language;
  }

  String get selectedLanguage => _selectedLanguage;

  String get getFavoriteMall => _favoriteMall;

  updateUserInfoApi({BuildContext context, UploadPreferencesModel data}) async {
    selectPreferencesSink.add(ApiResponse.loading(null));
    String userData = await SessionManager.getUserData();
    UserDataResponse _response = userDataResponseFromJson(userData);
    try {
      Map<String, String> patchQuery = {"state": "1"};
      dynamic user = await _repository.updateUserPreferencesApiRepository(
          userId: _response.username, params: data, map: patchQuery);
      debugPrint("testing__:-  success $user");
      if (user is DioError) {
        debugPrint("testing__:-   ${user.response.data}");
        selectPreferencesSink.add(ApiResponse.error(ErrorResponse()));
      } else {
        debugPrint("testing__:-   Profile updated successfully");
        updateUserOnLocal(data, context);
      }
    } catch (e) {
      debugPrint("error_in_updateUserInfoApi:-  $e");
      selectPreferencesSink.add(ApiResponse.error(e));
      if (e is UnknownException ||
          e is InvalidFormatException ||
          e is NoServiceFoundException ||
          e is NoInternetException ||
          e is FetchDataException ||
          e is UnauthorisedException ||
          e is BadRequestException) {
        selectPreferencesSink.add(
          ApiResponse.error(
            ErrorResponse(message: e.message),
          ),
        );
      } else {
        selectPreferencesSink.add(
          ApiResponse.error(
            ErrorResponse(message: e),
          ),
        );
      }
    }
  }

  void updateUserOnLocal(
      UploadPreferencesModel user, BuildContext context) async {
    try {
      String accessToken = await SessionManager.getJWTToken();
      String userData = await SessionManager.getUserData();
      UserDataResponse _response = userDataResponseFromJson(userData);
      UserDataResponse userDataResponse = UserDataResponse(
        accessToken: accessToken,
        lastName: _response.lastName,
        username: _response.username,
        userId: _response.userId,
        gender: _response.gender,
        dob: _response.dob,
        firstName: _response.firstName,
        cellnumber: _response.cellnumber,
        isLogin: _response.isLogin,
        isTester: _response.isTester,
        email: _response.email,
        clientApi: _response.clientApi,
        loginType: _response.loginType,
        loyaltyStatus: _response.loyaltyStatus,
        categories: user.preferences.categories,
        notification: user.preferences.notification.toString(),
        favouriteMall: user.preferences.favoriteMalls,
        language: user.preferences.defaultLanguage,
        currency: user.preferences.alternateCurrency,
        devices: _response.devices,
        registrationDate: _response.registrationDate,
      );
      SessionManager.setUserData(userDataResponseToJson(userDataResponse));

      debugPrint('login_response_tesing:-  ${_response.cellnumber}');
      selectPreferencesSink.add(ApiResponse.completed(ErrorResponse()));
    } catch (e) {
      debugPrint("login_success_testing:-  error $e");
      selectPreferencesSink.add(
        ApiResponse.error(
          ErrorResponse(message: e),
        ),
      );
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
