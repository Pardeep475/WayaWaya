import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/forgotpassword/model/error_response.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/settings/model/update_user_model.dart';
import 'package:wayawaya/network/live/exception_handling/exception_handling.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class MyAccountBloc {
  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  // ignore: close_sinks
  StreamController _genderController = StreamController<int>();

  StreamSink<int> get genderSink => _genderController.sink;

  Stream<int> get genderStream => _genderController.stream;

// ignore: close_sinks
  StreamController _profileController =
      StreamController<ApiResponse<ErrorResponse>>();

  StreamSink<ApiResponse<ErrorResponse>> get profileSink =>
      _profileController.sink;

  Stream<ApiResponse<ErrorResponse>> get profileStream =>
      _profileController.stream;

  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _dateOfBirth = '';
  String _phoneNumber = '';
  String _gender = '';

  final _repository = ApiRepository();

  Future setUpUserData() async {
    try {
      String userData = await SessionManager.getUserData();
      UserDataResponse _response = userDataResponseFromJson(userData);

      _setUpEmail(_response);
      _setUpFirstName(_response);
      _setUpLastName(_response);
      _setUpDateOfBirth(_response);
      _setUpPhoneNumber(_response);
      _setUpGender(_response);
      return;
    } catch (e) {
      debugPrint('account_testing:-   $e');
      return;
    }
  }

  _setUpGender(UserDataResponse _response) {
    try {
      _gender = _response.gender ?? '';
    } catch (e) {
      debugPrint('account_testing:-  email $e');
    }
  }

  _setUpEmail(UserDataResponse _response) {
    try {
      _email = _response.username ?? '';
    } catch (e) {
      debugPrint('account_testing:-  email $e');
    }
  }

  _setUpFirstName(UserDataResponse _response) {
    try {
      _firstName = _response.firstName ?? '';
    } catch (e) {
      debugPrint('account_testing:-  firstName $e');
    }
  }

  _setUpLastName(UserDataResponse _response) {
    try {
      _lastName = _response.lastName ?? '';
    } catch (e) {
      debugPrint('account_testing:-  lastName $e');
    }
  }

  _setUpDateOfBirth(UserDataResponse _response) {
    try {
      if (!Utils.checkNullOrEmpty(_response.dob)) {
        _dateOfBirth = Utils.dateConvert(_response.dob, "dd/MM/yyyy");
      }
    } catch (e) {
      debugPrint('account_testing:-  dob $e');
    }
  }

  _setUpPhoneNumber(UserDataResponse _response) {
    try {
      debugPrint('phone_number_testing: -   ${_response.cellnumber}');
      if (!Utils.checkNullOrEmpty(_response.cellnumber)) {
        dynamic _phoneNumbersList = jsonDecode(_response.cellnumber);
        _phoneNumbersList.forEach((element) {
          if (element["type"] == "mobile") {
            _phoneNumber = element["data"] ?? '';
          }
        });
      }
    } catch (e) {
      debugPrint('account_testing:-  cellNumber $e');
    }
  }

  String get fetchEmail => _email;

  String get fetchFirstName => _firstName;

  String get fetchLastName => _lastName;

  String get fetchDateOfBirth => _dateOfBirth;

  String get fetchPhoneNumber => _phoneNumber;

  String get fetchGender => _gender;

  updateUserInfoApi(
      {BuildContext context, String userId, UpdateUserModel data}) async {
    profileSink.add(ApiResponse.loading(null));
    try {
      Map<String, String> patchQuery = {"state": "1"};
      dynamic user = await _repository.updateUserApiRepository(
          userId: userId, params: data, map: patchQuery);
      debugPrint("testing__:-  success $user");
      if (user is DioError) {
        debugPrint("testing__:-   ${user.response.data}");
        profileSink.add(ApiResponse.error(ErrorResponse()));
      } else {
        debugPrint("testing__:-   Profile updated successfully");
        updateUserOnLocal(data, context);
      }
    } catch (e) {
      debugPrint("error_in_login_api:-  $e");
      profileSink.add(ApiResponse.error(e));
      if (e is UnknownException ||
          e is InvalidFormatException ||
          e is NoServiceFoundException ||
          e is NoInternetException ||
          e is FetchDataException ||
          e is UnauthorisedException ||
          e is BadRequestException) {
        debugPrint("error_in_login_api:-  e is exception");
        profileSink.add(
          ApiResponse.error(
            ErrorResponse(message: e.message),
          ),
        );
      } else {
        debugPrint("error_in_login_api:-  $e is String");
        profileSink.add(
          ApiResponse.error(
            ErrorResponse(message: e),
          ),
        );
      }
    }
  }

  void updateUserOnLocal(UpdateUserModel user, BuildContext context) async {
    try {
      String accessToken = await SessionManager.getJWTToken();
      String userData = await SessionManager.getUserData();
      UserDataResponse _response = userDataResponseFromJson(userData);
      UserDataResponse userDataResponse = UserDataResponse(
        accessToken: accessToken,
        lastName: user.lastName,
        username: _response.username,
        userId: _response.userId,
        gender: user.title,
        dob: user.dateOfBirth,
        firstName: user.firstName,
        cellnumber: user.cellNumberList == null
            ? null
            : json.encode(user.cellNumberList),
        isLogin: _response.isLogin,
        isTester: _response.isTester,
        email: _response.email,
        clientApi: _response.clientApi,
        loginType: _response.loginType,
        loyaltyStatus: _response.loyaltyStatus,
        categories: _response.categories,
        notification: _response.notification,
        favouriteMall: _response.favouriteMall,
        language: _response.language,
        currency: _response.currency,
        devices: _response.devices,
        registrationDate: _response.registrationDate,
      );
      SessionManager.setUserData(userDataResponseToJson(userDataResponse));

      debugPrint('login_response_tesing:-  ${_response.cellnumber}');
      profileSink.add(ApiResponse.completed(ErrorResponse()));
    } catch (e) {
      debugPrint("login_success_testing:-  error $e");
      profileSink.add(
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
    debugPrint('main_menu_permission_testing:--   ${itemList.length}');
    mainMenuPermissionSink.add(itemList);
    return itemList;
  }
}
