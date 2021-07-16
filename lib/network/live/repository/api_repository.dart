import 'package:wayawaya/app/auth/forgotpassword/model/authentication_code_model.dart';
import 'package:wayawaya/app/auth/login/model/user_model.dart';
import 'package:wayawaya/app/auth/signup/model/sign_up_model.dart';
import 'package:wayawaya/app/preferences/model/upload_preferences_model.dart';
import 'package:wayawaya/app/settings/model/update_user_model.dart';
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

  Future<dynamic> fetchUserDetailRepository(
      {String authHeader, String email}) async {
    // String authHeader = await SessionManager.getAuthHeader();
    final response = await _apiProvider.get(
        url: '${NetworkConstants.fetch_user_detail}/$email',
        authHeader: authHeader);
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

  Future<dynamic> registerUserApiRepository(SignUpModel signUpModel) async {
    String authHeader = await SessionManager.getAuthHeader();
    final response = await _apiProvider.post(
        url: '${NetworkConstants.register_user_end_point}',
        params: signUpModelToJson(signUpModel),
        authHeader: authHeader);
    return response;
  }

  Future<dynamic> updateUserApiRepository(
      {String userId, dynamic params, Map<String, dynamic> map}) async {
    String authHeader = await SessionManager.getJWTToken();
    final response = await _apiProvider.patch(
        url: '${NetworkConstants.update_user_end_point}$userId',
        params: updateUserModelResponseToJson(params),
        authHeader: authHeader,
        map: map);

    return response;
  }

  Future<dynamic> updateUserPreferencesApiRepository(
      {String userId, dynamic params, Map<String, dynamic> map}) async {
    String authHeader = await SessionManager.getJWTToken();
    final response = await _apiProvider.patch(
        url: '${NetworkConstants.update_user_end_point}$userId',
        params: uploadPreferencesModelToJson(params),
        authHeader: authHeader,
        map: map);

    return response;
  }

  Future<dynamic> fetchCampaignApiRepository(
      {String authorization, Map<String, dynamic> map}) async {
    // https://api.omnistride.net/api/v1/campaigns?where ={"status": "approved", "_updated":{"$gt":"2021-06-10 09:57:28"}, "campaign_channels.omni_channel_id":{"$elemMatch":{"$eq":"ec6f1eb8901b4f419e2e25e4fa55a3e0"}}}&enable=true

    final response = await _apiProvider.get(
        url:
            '${NetworkConstants.campaigns_end_point}?where ={"status": "approved", "_updated":{"\$gt":"2021-06-10 09:57:28"}, "campaign_channels.omni_channel_id":{"\$elemMatch":{"\$eq":"ec6f1eb8901b4f419e2e25e4fa55a3e0"}}}&enable=true',
        queryParams: map,
        authHeader: authorization);
    return response;
  }

  Future<dynamic> venueMeApiRepository(
      {String authorization, Map<String, dynamic> map}) async {
    final response = await _apiProvider.get(
        url: '${NetworkConstants.venue_me_end_point}',
        queryParams: map,
        authHeader: authorization);
    return response;
  }

  Future<dynamic> retailUnitApiRepository(
      {String authorization, Map<String, dynamic> map}) async {
    final response = await _apiProvider.get(
        url: '${NetworkConstants.retail_unit_end_point}',
        queryParams: map,
        authHeader: authorization);
    return response;
  }

  Future<dynamic> venueApiRepository({String authorization}) async {
    final response = await _apiProvider.get(
        url: '${NetworkConstants.venues_end_point}', authHeader: authorization);
    return response;
  }

  Future<dynamic> loyaltyApiRepository(
      {String authorization, Map<String, dynamic> map}) async {
    final response = await _apiProvider.get(
        url: '${NetworkConstants.loyalty_transactions_end_point}',
        authHeader: authorization);
    return response;
  }
}
