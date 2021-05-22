import 'package:wayawaya/app/auth/forgotpassword/model/authentication_code_model.dart';
import 'package:wayawaya/app/auth/login/model/user_model.dart';
import 'package:wayawaya/network/live/base/api_base_helper.dart';

import '../network_constants.dart';

class ApiRepository {
  static final ApiRepository _apiRepository = ApiRepository._internal();

  factory ApiRepository() {
    return _apiRepository;
  }

  ApiRepository._internal();

  final _apiProvider = ApiBaseHelper();

  Future<dynamic> loginApiRepository(UserModel userModel) async {
    final response = await _apiProvider.post(
      url: NetworkConstants.login_end_point,
      params: userModelToJson(userModel),
    );

    // return UserApiResponse.fromJson(response);
    return response;
  }

  Future<dynamic> forgotPasswordApiRepository(String email) async {
    final response = await _apiProvider.get(
      url: '${NetworkConstants.forgot_password_end_point}$email',
    );
    return response;
  }

  Future<dynamic> authenticationCodeApiRepository(
      AuthenticationCodeModel authenticationCodeModel) async {
    final response = await _apiProvider.post(
      url: '${NetworkConstants.new_password_end_point}',
      params: authenticationCodeModelToJson(authenticationCodeModel),
    );
    return response;
  }
}
