import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:wayawaya/app/auth/forgotpassword/model/error_response.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/auth/login/model/user_model.dart';
import 'package:wayawaya/network/live/exception_handling/exception_handling.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';

class LoginBloc {
  StreamController _loginController =
      StreamController<ApiResponse<ErrorResponse>>();

  StreamSink<ApiResponse<ErrorResponse>> get loginSink => _loginController.sink;

  Stream<ApiResponse<ErrorResponse>> get loginStream => _loginController.stream;

  final _repository = ApiRepository();

  loginApi(UserModel userModel, String differ) async {
    loginSink.add(ApiResponse.loading(null));
    try {
      dynamic user = await _repository.loginApiRepository(userModel);
      debugPrint("testing__:-  success $user");

      if (user is DioError) {
        if (user.response.statusCode == 401) {
          debugPrint('testing_   :-  ${user.response.statusCode}');
          loginSink.add(
            ApiResponse.error(
              ErrorResponse(differ: differ, message: '401'),
            ),
          );
        } else {
          loginSink.add(
            ApiResponse.error(
              ErrorResponse(
                  differ: differ, message: user.response.data['message']),
            ),
          );
          debugPrint("testing__:-   ${user.response.data['message']}");
        }
      } else {
        debugPrint('login_api_testing:-  $user');
        _jwtParse(differ, user);
        // loginSink.add(ApiResponse.completed(ErrorResponse(differ: differ)));
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
        loginSink.add(
          ApiResponse.error(
            ErrorResponse(differ: differ, message: e.message),
          ),
        );
      } else {
        debugPrint("error_in_login_api:-  $e is String");
        loginSink.add(
          ApiResponse.error(
            ErrorResponse(differ: differ, message: e),
          ),
        );
      }
    }
  }

  _jwtParse(String differ, dynamic user) async {
    try {
      debugPrint('login_testing:- access_token  ${user.data['access_token']}');
      debugPrint(
          'login_testing:- refresh_token  ${user.data['refresh_token']}');
      SessionManager.setJWTToken(user.data['access_token']);
      SessionManager.setRefreshToken(user.data['refresh_token']);

      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(user.data['access_token']);
      debugPrint('login_testing:- decodedToken  $decodedToken');

      var clientApi = decodedToken['clientapi'];
      var dob = decodedToken['dob'];
      var role = decodedToken['role'];
      var firstName = decodedToken['first_name'];
      var lastName = decodedToken['last_name'];
      var userName = decodedToken['username'];
      var userId = decodedToken['userid'];

      debugPrint(
          'login_testing:-   clientApi $clientApi  dob  $dob   role  $role');
      debugPrint(
          'login_testing:-   firstName $firstName  lastName  $lastName   userName  $userName  userId $userId');

      UserDataResponse userDataResponse = UserDataResponse(
          isLogin: true,
          accessToken: user.data['access_token'],
          clientApi: decodedToken['clientapi'],
          firstName: decodedToken['first_name'],
          lastName: decodedToken['last_name'],
          dob: decodedToken['dob'],
          loginType: decodedToken['role'] == 'guest' ? 'native' : 'facebook',
          username: decodedToken['username'],
          userId: decodedToken['userid']);
      SessionManager.setUserData(userDataResponseToJson(userDataResponse));
      String userData = await SessionManager.getUserData();
      UserDataResponse response = userDataResponseFromJson(userData);
      debugPrint('login_response_tesing:-  ${response.clientApi}');
      List<String> deviceList = [];
      String currentDevice = await SessionManager.getCurrentDevice();
      deviceList.add(currentDevice);
      var devicesJson = jsonEncode(deviceList.toString());

      final Map<String, String> queryParams = {
        AppString.STATE: '0',
      };
      fetchUserDetails(
          differ: differ,
          userId: decodedToken['username'],
          map: queryParams,
          data: devicesJson);
    } catch (e) {
      debugPrint('jwt_parse_testing:-  $e');
      loginSink.add(
        ApiResponse.error(
          ErrorResponse(differ: differ, message: e.message),
        ),
      );
    }
  }

  fetchUserDetails(
      {String userId,
      dynamic data,
      Map<String, dynamic> map,
      String differ}) async {
    // , data: '{"devices":["OPPO~^CPH1911~^ANDROID10"]}', map: map
    try {
      String authToken = await SessionManager.getJWTToken();
      dynamic user = await _repository.fetchUserDetailRepository(
          authHeader: authToken, email: userId);
      debugPrint("testing__:-  success $user");

      if (user is DioError) {
        if (user.response.statusCode == 401) {
          debugPrint('testing_   :-  ${user.response.statusCode}');
          loginSink.add(
            ApiResponse.error(
              ErrorResponse(differ: differ, message: '401'),
            ),
          );
        } else {
          loginSink.add(
            ApiResponse.error(
              ErrorResponse(
                  differ: differ, message: user.response.data['message']),
            ),
          );
          debugPrint("testing__:-   ${user.response.data['message']}");
        }
      } else {
        loginSink.add(ApiResponse.completed(ErrorResponse(differ: differ)));
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
        loginSink.add(
          ApiResponse.error(
            ErrorResponse(differ: differ, message: e.message),
          ),
        );
      } else {
        debugPrint("error_in_login_api:-  $e is String");
        loginSink.add(
          ApiResponse.error(
            ErrorResponse(differ: differ, message: e),
          ),
        );
      }
    }
  }

  dispose() {
    _loginController?.close();
  }
}
