import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/forgotpassword/model/error_response.dart';
import 'package:wayawaya/app/auth/signup/model/sign_up_model.dart';
import 'package:wayawaya/network/live/exception_handling/exception_handling.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';

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
        debugPrint('login_api_testing:-  $user');
        signUpSink.add(ApiResponse.completed(ErrorResponse(differ: differ)));
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
}
