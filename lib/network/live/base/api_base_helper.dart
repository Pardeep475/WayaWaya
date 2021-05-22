import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/network/live/exception_handling/exception_handling.dart';
import 'package:wayawaya/utils/app_strings.dart';
import '../network_constants.dart';

class ApiBaseHelper {
  static final ApiBaseHelper _apiBaseHelper = ApiBaseHelper._internal();

  factory ApiBaseHelper() {
    return _apiBaseHelper;
  }

  ApiBaseHelper._internal();

  static final dio = Dio();

  Future<dynamic> get({String url}) async {
    debugPrint('api_url  :-  ${NetworkConstants.base_url}$url');
    try {
      final response = await dio.get('${NetworkConstants.base_url}$url',
          options: Options(
            headers: {
              "Authorization":
                  "Bearer twG0iiIbMw3IxS5MMw|R6f29ZKdAz7TaDA1cJFFSwtysP88doc_Vwq8EbJfPIN2I"
            },
          ));
      debugPrint('pardeep_testing:-  ${response.statusCode}');
      return response;
    } on SocketException {
      throw NoInternetException(AppString.check_your_internet_connectivity);
    } on HttpException {
      throw NoServiceFoundException(AppString.no_service_found_exception);
    } on FormatException {
      throw InvalidFormatException(AppString.invalid_format_exception);
    } catch (e) {
      debugPrint("pardeep_testing:-   ${e.toString()}");
      if (e is DioError) {
        return e;
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  Future<dynamic> post({String url, dynamic params}) async {
    try {
      debugPrint('api_url  :-  ${NetworkConstants.base_url}$url');
      debugPrint('api_params   :-   $params    ');
      final response = await dio.post('${NetworkConstants.base_url}$url',
          data: params,
          options: Options(
            headers: {
              "Authorization":
                  "Bearer twG0iiIbMw3IxS5MMw|R6f29ZKdAz7TaDA1cJFFSwtysP88doc_Vwq8EbJfPIN2I"
            },
          ));
      debugPrint('api_response_print:-    $response');

      return response;
    } on SocketException {
      throw NoInternetException(AppString.check_your_internet_connectivity);
    } on HttpException {
      throw NoServiceFoundException(AppString.no_service_found_exception);
    } on FormatException {
      throw InvalidFormatException(AppString.invalid_format_exception);
    } catch (e) {
      debugPrint("pardeep_testing:-   ${e.toString()}");
      if (e is DioError) {
        return e;
      } else {
        throw UnknownException(e.toString());
      }
    }
  }

  dynamic _returnResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      // return json.decode(response.data);
      case 400:
        throw BadRequestException(AppString.bad_request_exception);
      case 401:
      case 403:
        throw UnauthorisedException(AppString.un_authorised_exception);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

// class CustomInterceptors extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     print('REQUEST[${options.method}] => PATH: ${options.path}');
//     return super.onRequest(options, handler);
//   }
//   @override
//   Future onResponse(Response response, ResponseInterceptorHandler handler) {
//     print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
//     return super.onResponse(response, handler);
//   }
//   @override
//   Future onError(DioError err, ErrorInterceptorHandler handler) {
//     print('ERROR[${err.response?.statusCode}] => PATH: ${err.request.path}');
//     return super.onError(err, handler);
//   }
// }
