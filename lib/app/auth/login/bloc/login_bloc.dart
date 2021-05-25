import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/forgotpassword/model/error_response.dart';
import 'package:wayawaya/app/auth/login/model/user_api_response.dart';
import 'package:wayawaya/app/auth/login/model/user_model.dart';
import 'package:wayawaya/network/live/exception_handling/exception_handling.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';

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
                  differ: differ,
                  message: user.response.data['message']),
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
