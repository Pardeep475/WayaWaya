import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/settings/model/device_model.dart';
import 'package:wayawaya/network/live/exception_handling/exception_handling.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class MyDevicesBloc {
  // ignore: close_sinks
  StreamController _myDevicesController = StreamController<List<DeviceModel>>();

  StreamSink<List<DeviceModel>> get devicesSink => _myDevicesController.sink;

  Stream<List<DeviceModel>> get deviceStream => _myDevicesController.stream;

  // ignore: close_sinks
  StreamController _mainMenuPermissionsController =
      StreamController<List<MainMenuPermission>>();

  StreamSink<List<MainMenuPermission>> get mainMenuPermissionSink =>
      _mainMenuPermissionsController.sink;

  Stream<List<MainMenuPermission>> get mainMenuPermissionStream =>
      _mainMenuPermissionsController.stream;

  final _repository = ApiRepository();

  fetchDevicesData(BuildContext context) async {
    try {
      String userData = await SessionManager.getUserData();
      UserDataResponse _response = userDataResponseFromJson(userData);
      _setUpDeviceData(_response);
      Utils.checkConnectivity().then((value) {
        if (value) {
          // fetch data from server
          fetchUserDetails(userId: _response.username, context: context);
        } else {
          // show error
          _showErrorDialog(
            context: context,
            icon: Icon(
              FontAwesomeIcons.exclamationTriangle,
              color: AppColor.orange_500,
            ),
            title: AppString.sorry,
            content: AppString.device_sync_error,
            buttonText: AppString.ok.toUpperCase(),
            onPressed: () => Navigator.pop(context),
          );
        }
      });
    } catch (e) {
      debugPrint('device_list_testing:-  $e');
    }
  }

  fetchUserDetails({String userId, BuildContext context}) async {
    try {
      debugPrint("testing__:-  success $userId");
      Utils.commonProgressDialog(context);
      String authToken = await SessionManager.getJWTToken();
      dynamic user = await _repository.fetchUserDetailRepository(
          authHeader: authToken, email: userId);
      debugPrint("testing__:-  success $user");

      if (user is DioError) {
        if (user.response.statusCode == 401) {
          Navigator.pop(context);
          debugPrint('testing_   :-  ${user.response.statusCode}');
          _showErrorDialog(
            context: context,
            icon: Icon(
              FontAwesomeIcons.exclamationTriangle,
              color: AppColor.orange_500,
            ),
            title: AppString.sorry,
            content: AppString.device_sync_error,
            buttonText: AppString.ok.toUpperCase(),
            onPressed: () => Navigator.pop(context),
          );
        } else {
          Navigator.pop(context);
          _showErrorDialog(
            context: context,
            icon: Icon(
              FontAwesomeIcons.exclamationTriangle,
              color: AppColor.orange_500,
            ),
            title: AppString.sorry,
            content: AppString.device_sync_error,
            buttonText: AppString.ok.toUpperCase(),
            onPressed: () => Navigator.pop(context),
          );
          debugPrint("testing__:-   ${user.response.data['message']}");
        }
      } else {
        loginSuccess(user, context);
      }
    } catch (e) {
      debugPrint("error_in_login_api:-  $e");
      // loginSink.add(ApiResponse.error(e));
      if (e is UnknownException ||
          e is InvalidFormatException ||
          e is NoServiceFoundException ||
          e is NoInternetException ||
          e is FetchDataException ||
          e is UnauthorisedException ||
          e is BadRequestException) {
        debugPrint("error_in_login_api:-  e is exception");
        Navigator.pop(context);
        _showErrorDialog(
          context: context,
          icon: Icon(
            FontAwesomeIcons.exclamationTriangle,
            color: AppColor.orange_500,
          ),
          title: AppString.sorry,
          content: AppString.device_sync_error,
          buttonText: AppString.ok.toUpperCase(),
          onPressed: () => Navigator.pop(context),
        );
      } else {
        debugPrint("error_in_login_api:-  $e is String");
        Navigator.pop(context);
        _showErrorDialog(
          context: context,
          icon: Icon(
            FontAwesomeIcons.exclamationTriangle,
            color: AppColor.orange_500,
          ),
          title: AppString.sorry,
          content: AppString.device_sync_error,
          buttonText: AppString.ok.toUpperCase(),
          onPressed: () => Navigator.pop(context),
        );
      }
    }
  }

  void loginSuccess(user, context) async {
    try {
      String accessToken = await SessionManager.getJWTToken();

      UserDataResponse userDataResponse = UserDataResponse(
        accessToken: accessToken,
        lastName: user.data['last_name'] == null
            ? null
            : user.data['last_name'].toString(),
        username: user.data['user_name'] == null
            ? null
            : user.data['user_name'].toString(),
        userId: user.data['_id'] == null ? null : user.data['_id'].toString(),
        gender: user.data[''] == null ? null : user.data[''].toString(),
        dob: user.data['date_of_birth'] == null
            ? null
            : user.data['date_of_birth'].toString(),
        firstName: user.data['first_name'] == null
            ? null
            : user.data['first_name'].toString(),
        cellnumber: user.data['cell_number_list'] == null
            ? null
            : json.encode(user.data['cell_number_list']),
        isLogin: true,
        isTester: user.data['tester_flag'],
        email: user.data['email_list'] == null
            ? null
            : json.encode(user.data['email_list']),
        clientApi: user.data['social_media'] == null
            ? null
            : user.data['social_media'].toString(),
        loginType: user.data['social_media'] == null
            ? null
            : user.data['social_media'].toString(),
        loyaltyStatus: user.data['loyalty_status'] == null
            ? null
            : user.data['loyalty_status'].toString(),
        categories: user.data['preferences'] == null
            ? null
            : user.data['preferences']['categories'] == null
                ? null
                : user.data['preferences']['categories'],
        notification: user.data['preferences'] == null
            ? null
            : user.data['preferences']['notification'] == null
                ? null
                : user.data['preferences']['notification'].toString(),
        favouriteMall: user.data['preferences'] == null
            ? null
            : user.data['preferences']['favorite_malls'] == null
                ? null
                : user.data['preferences']['favorite_malls'].toString(),
        language: user.data['preferences'] == null
            ? null
            : user.data['preferences']['default_language'] == null
                ? null
                : user.data['preferences']['default_language'].toString(),
        currency: user.data['preferences'] == null
            ? null
            : user.data['preferences']['alternate_currency'] == null
                ? null
                : user.data['preferences']['alternate_currency'].toString(),
        devices: user.data['devices'] == null
            ? null
            : user.data['devices'].toString(),
        registrationDate: user.data['registration_date'] == null
            ? null
            : user.data['registration_date'].toString(),
      );
      SessionManager.setUserData(userDataResponseToJson(userDataResponse));

      String userData = await SessionManager.getUserData();
      UserDataResponse _response = userDataResponseFromJson(userData);
      debugPrint('login_response_tesing:-  ${_response.cellnumber}');
      Navigator.pop(context);
      _setUpDeviceData(_response);
    } catch (e) {
      debugPrint("login_success_testing:-  error $e");
      Navigator.pop(context);
      _showErrorDialog(
        context: context,
        icon: Icon(
          FontAwesomeIcons.exclamationTriangle,
          color: AppColor.orange_500,
        ),
        title: AppString.sorry,
        content: AppString.device_sync_error,
        buttonText: AppString.ok.toUpperCase(),
        onPressed: () => Navigator.pop(context),
      );
    }
  }

  _showErrorDialog(
      {Icon icon,
      String title,
      String content,
      String buttonText,
      VoidCallback onPressed,
      BuildContext context}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonErrorDialog(
                icon: icon,
                title: title,
                content: content,
                buttonText: buttonText,
                onPressed: onPressed,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  _setUpDeviceData(UserDataResponse response) async {
    try {
      List<DeviceModel> _deviceModelList = [];
      String currentDevice = await SessionManager.getCurrentDevice();
      String device = response.devices.replaceAll('[', '');
      String deviceArrayString = device.replaceAll(']', '');
      var deviceList = deviceArrayString.split(',');
      for (int i = 0; i < deviceList.length; i++) {
        String item = deviceList[i];
        debugPrint('device_list_testing:-   $item');
        if (currentDevice.trim() == item.trim()) {
        } else {}

        var itemList = item.split(RegExp(r"~\^"));
        String os = itemList[2].trim();
        debugPrint(
            'device_list_testing:-   ${currentDevice.trim() == item.trim()}     ${currentDevice.trim()}         ${item.trim()}');
        if (itemList[2].contains(AppString.ANDROID_NAME)) {
          os = itemList[2].replaceAll(AppString.ANDROID_NAME, '').trim();
        } else if (itemList[2].contains(AppString.IOS_NAME)) {
          os = itemList[2].replaceAll(AppString.IOS_NAME, '').trim();
        } else if (itemList[2].contains('iOS')) {
          os = itemList[2].replaceAll('iOS', '').trim();
        }

        _deviceModelList.add(
          DeviceModel(
              isCurrentDevice: currentDevice.trim() == item.trim(),
              model: itemList[1].trim(),
              manufacturer: itemList[0].trim(),
              os: os),
        );
      }
      devicesSink.add(_deviceModelList);
    } catch (e) {
      debugPrint('device_list_testing:-  $e');
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
