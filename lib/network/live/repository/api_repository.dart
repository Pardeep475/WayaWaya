import 'package:wayawaya/app/auth/forgotpassword/model/authentication_code_model.dart';
import 'package:wayawaya/app/auth/login/model/user_model.dart';
import 'package:wayawaya/network/live/base/api_base_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';

import '../network_constants.dart';

class ApiRepository {
  static final ApiRepository _apiRepository = ApiRepository._internal();

  factory ApiRepository() {
    return _apiRepository;
  }

  ApiRepository._internal();

  final _apiProvider = ApiBaseHelper();

  Future<dynamic> loginApiRepository(UserModel userModel) async {
    String authHeader = await SessionManager.getAuthHeader();
    final response = await _apiProvider.post(
        url: NetworkConstants.login_end_point,
        params: userModelToJson(userModel),
        authHeader: authHeader);

    // return UserApiResponse.fromJson(response);
    return response;
  }

  Future<dynamic> fetchUserDetailRepository({String authHeader,String email}) async {
    // String authHeader = await SessionManager.getAuthHeader();
    final response = await _apiProvider.get(
        url: '${NetworkConstants.fetch_user_detail}/$email',
        authHeader: authHeader);
    return response;
  }

  Future<dynamic> fetchUserDetailApiRepository(
      {String authHeader,
      String userId,
      dynamic data,
      Map<String, dynamic> map}) async {
    final response = await _apiProvider.fetchUserDetail(
        url: '${NetworkConstants.fetch_user_detail}/$userId',
        params: data,
        authHeader: authHeader,
        map: map);

    // return UserApiResponse.fromJson(response);
    return response;
  }

  Future<dynamic> forgotPasswordApiRepository(String email) async {
    String authHeader = await SessionManager.getAuthHeader();
    final response = await _apiProvider.get(
        url: '${NetworkConstants.forgot_password_end_point}$email',
        authHeader: authHeader);
    return response;
  }

  Future<dynamic> authenticationCodeApiRepository(
      AuthenticationCodeModel authenticationCodeModel) async {
    String authHeader = await SessionManager.getAuthHeader();
    final response = await _apiProvider.post(
        url: '${NetworkConstants.new_password_end_point}',
        params: authenticationCodeModelToJson(authenticationCodeModel),
        authHeader: authHeader);
    return response;
  }
}
