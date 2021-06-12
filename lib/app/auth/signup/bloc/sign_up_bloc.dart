import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/forgotpassword/model/error_response.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/auth/signup/model/sign_up_model.dart';
import 'package:wayawaya/network/live/exception_handling/exception_handling.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/utils/session_manager.dart';

class SignUpBloc {
  StreamController _tACController = StreamController<bool>();

  StreamSink<bool> get tACSink => _tACController.sink;

  Stream<bool> get tACStream => _tACController.stream;

  StreamController _newsLetterController = StreamController<bool>();

  StreamSink<bool> get newsLetterSink => _newsLetterController.sink;

  Stream<bool> get newsLetterStream => _newsLetterController.stream;

  StreamController _genderController = StreamController<int>();

  StreamSink<int> get genderSink => _genderController.sink;

  Stream<int> get genderStream => _genderController.stream;

  StreamController _signUpController =
      StreamController<ApiResponse<ErrorResponse>>();

  StreamSink<ApiResponse<ErrorResponse>> get signUpSink =>
      _signUpController.sink;

  Stream<ApiResponse<ErrorResponse>> get signUpStream =>
      _signUpController.stream;

  final _repository = ApiRepository();

  registerApi(SignUpModel signUpModel, String differ) async {
    signUpSink.add(ApiResponse.loading(null));
    try {
      dynamic user = await _repository.registerUserApiRepository(signUpModel);
      debugPrint("testing__:-  success $user");

      if (user is DioError) {
        if (user.response.statusCode == 422) {
          debugPrint('testing_   :-  ${user.response.data["_error"]}');
          signUpSink.add(
            ApiResponse.error(
              ErrorResponse(
                  differ: differ,
                  message: user.response.data['_error']['message']),
            ),
          );
        } else {
          signUpSink.add(
            ApiResponse.error(
              ErrorResponse(
                  differ: differ,
                  message: user.response.data['_error']['message']),
            ),
          );
          debugPrint(
              "testing__:-   ${user.response.data['_error']['message']}");
        }
      } else {
        debugPrint('login_api_testing:-  $user');
        SessionManager.setJWTToken(user.data['access_token']);
        SessionManager.setRefreshToken(user.data['refresh_token']);
        fetchUserDetails(
          differ: 'USER_DETAILS',
          userId: signUpModel.userName,
        );
        // signUpSink.add(ApiResponse.completed(ErrorResponse(differ: differ)));
      }
    } catch (e) {
      debugPrint("error_in_login_api:-  $e");
      // signUpSink.add(ApiResponse.error(e));
      if (e is UnknownException ||
          e is InvalidFormatException ||
          e is NoServiceFoundException ||
          e is NoInternetException ||
          e is FetchDataException ||
          e is UnauthorisedException ||
          e is BadRequestException) {
        debugPrint("error_in_login_api:-  e is exception");
        signUpSink.add(
          ApiResponse.error(
            ErrorResponse(differ: differ, message: e.message),
          ),
        );
      } else {
        debugPrint("error_in_login_api:-  $e is String");
        signUpSink.add(
          ApiResponse.error(
            ErrorResponse(differ: differ, message: e),
          ),
        );
      }
    }
  }

  fetchUserDetails({String userId, String differ}) async {
    // , data: '{"devices":["OPPO~^CPH1911~^ANDROID10"]}', map: map
    try {
      String authToken = await SessionManager.getJWTToken();
      dynamic user = await _repository.fetchUserDetailRepository(
          authHeader: authToken, email: userId);
      debugPrint("testing__:-  success $user");

      if (user is DioError) {
        if (user.response.statusCode == 401) {
          debugPrint('testing_   :-  ${user.response.statusCode}');
          signUpSink.add(
            ApiResponse.error(
              ErrorResponse(differ: differ, message: '401'),
            ),
          );
        } else {
          signUpSink.add(
            ApiResponse.error(
              ErrorResponse(
                  differ: differ, message: user.response.data['message']),
            ),
          );
          debugPrint("testing__:-   ${user.response.data['message']}");
        }
      } else {
        loginSuccess(user, differ);
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
        signUpSink.add(
          ApiResponse.error(
            ErrorResponse(differ: differ, message: e.message),
          ),
        );
      } else {
        debugPrint("error_in_login_api:-  $e is String");
        signUpSink.add(
          ApiResponse.error(
            ErrorResponse(differ: differ, message: e),
          ),
        );
      }
    }
  }

  dispose() {
    _tACController?.close();
    _newsLetterController?.close();
    _genderController?.close();
    _signUpController?.close();
  }

  void loginSuccess(user, differ) async {
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
      UserDataResponse response = userDataResponseFromJson(userData);
      debugPrint('login_response_tesing:-  ${response.cellnumber}');
      signUpSink.add(ApiResponse.completed(ErrorResponse(differ: differ)));
    } catch (e) {
      debugPrint("login_success_testing:-  error $e");
      signUpSink.add(
        ApiResponse.error(
          ErrorResponse(differ: differ, message: 'UserDetailError'),
        ),
      );
    }
  }
}
