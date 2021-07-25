import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/forgotpassword/model/authentication_code_model.dart';
import 'package:wayawaya/app/auth/forgotpassword/model/error_response.dart';
import 'package:wayawaya/network/live/exception_handling/exception_handling.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';

class ForgotPasswordBloc {
  StreamController _loginController =
      StreamController<ApiResponse<ErrorResponse>>();

  StreamSink<ApiResponse<ErrorResponse>> get loginSink => _loginController.sink;

  Stream<ApiResponse<ErrorResponse>> get loginStream => _loginController.stream;

  final _repository = ApiRepository();

  forgotPasswordApi(String email, String differ) async {
    loginSink.add(ApiResponse.loading(null));
    try {
      dynamic user = await _repository.forgotPasswordApiRepository(email);
      debugPrint("testing__:-  success $user");

      if (user is DioError) {
        debugPrint("testing__:-   ${user.response.data['_error']['message']}");
        loginSink.add(ApiResponse.error(ErrorResponse(
            differ: differ, message: user.response.data['_error']['message'])));
      } else {
        loginSink.add(ApiResponse.completed(ErrorResponse(differ: differ)));
      }
    } catch (e) {
      debugPrint("error_in_forgot_password_api:-  $e");
      // loginSink.add(ApiResponse.error(e));
      if (e is UnknownException ||
          e is InvalidFormatException ||
          e is NoServiceFoundException ||
          e is NoInternetException ||
          e is FetchDataException ||
          e is UnauthorisedException ||
          e is BadRequestException) {
        loginSink.add(
          ApiResponse.error(
            ErrorResponse(differ: differ, message: e.message),
          ),
        );
      } else {
        loginSink.add(
          ApiResponse.error(
            ErrorResponse(differ: differ, message: e),
          ),
        );
      }
    }
    /*finally {
      // loginSink.add(ApiResponse.completed('Login successfully'));
    }*/
  }

  authenticationCodeApi(String email,
      AuthenticationCodeModel authenticationCodeModel, String differ) async {
    loginSink.add(ApiResponse.loading(null));
    try {
      dynamic user = await _repository
          .authenticationCodeApiRepository(authenticationCodeModel);

      if (user is DioError) {
        debugPrint("testing__:-   ${user.response.data['_error']['message']}");
        loginSink.add(ApiResponse.error(ErrorResponse(
            differ: differ, message: user.response.data['_error']['message'])));
      } else {
        loginSink.add(ApiResponse.completed(ErrorResponse(differ: differ)));
      }

      debugPrint("testing__:-  success $user");
    } catch (e) {
      debugPrint("error_in_authenticationCodeApi:-  ${e}");
      // loginSink.add(ApiResponse.error(e));
      if (e is UnknownException ||
          e is InvalidFormatException ||
          e is NoServiceFoundException ||
          e is NoInternetException ||
          e is FetchDataException ||
          e is UnauthorisedException ||
          e is BadRequestException) {
        loginSink.add(
          ApiResponse.error(
            ErrorResponse(differ: differ, message: e.message),
          ),
        );
      } else {
        loginSink.add(
          ApiResponse.error(
            ErrorResponse(differ: differ, message: e),
          ),
        );
      }
    }
    /*finally {
      // loginSink.add(ApiResponse.completed('Login successfully'));
    }*/
  }

  dispose() {
    _loginController?.close();
  }
}
