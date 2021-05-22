import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/login/model/user_api_response.dart';
import 'package:wayawaya/app/auth/login/model/user_model.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';

class LoginBloc {
  StreamController _loginController =
      StreamController<ApiResponse<UserApiResponse>>();

  StreamSink<ApiResponse<UserApiResponse>> get loginSink =>
      _loginController.sink;

  Stream<ApiResponse<UserApiResponse>> get loginStream =>
      _loginController.stream;

  final _repository = ApiRepository();

  loginApi(UserModel userModel) async {
    loginSink.add(ApiResponse.loading(null));
    try {
      dynamic user = await _repository.loginApiRepository(userModel);
      debugPrint("testing__:-  success $user");
      // loginSink.add(ApiResponse.completed(user));
    } catch (e) {
      debugPrint("error_in_login_api:-  $e");
      loginSink.add(ApiResponse.error(e));
    }
    /*finally {
      // loginSink.add(ApiResponse.completed('Login successfully'));
    }*/
  }

  dispose() {
    _loginController?.close();
  }
}
