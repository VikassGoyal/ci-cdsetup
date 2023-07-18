import 'package:conet/config/app_config.dart';
import 'package:conet/constants/enums.dart';
import 'package:conet/repositories/interceptors/token_interceptor.dart';
import 'package:conet/repositories/retrofit/api_client.dart';
import 'package:conet/utils/get_it.dart';
import 'package:dio/dio.dart';

import '../api_models/changepassword_request_model/changepassword_request_body.dart';

class UserRepository {
  UserRepository() {
    final dio = Dio(BaseOptions(
        connectTimeout: const Duration(milliseconds: 7000), receiveTimeout: const Duration(milliseconds: 7000)));

    // Log requests in development.
    if (locator<AppConfig>().environmentType == EnvironmentType.development) {
      dio.interceptors.add(
        LogInterceptor(request: true, requestHeader: true, requestBody: true, responseHeader: true, responseBody: true),
      );
    }

    // Add refresh token interceptor.
    dio.interceptors.add(TokenInterceptor(dioClient: dio));
    _apiClient = ApiClient(dio, baseUrl: locator<AppConfig>().baseApiUrl);

    print('UserRepository initialised');
  }

  late final ApiClient _apiClient;

  login(requestBody) async {
    var response = await _apiClient.login(requestBody);

    return response;
  }

  signup(requestBody) async {
    var response = await _apiClient.signup(requestBody);
    return response;
  }

  // otpVerification(requestBody) async {
  //   var response = await _apiBaseHelper.postWithoutToken("loginwithotp", requestBody);
  //   return response;
  // }

  changePassword(ChangePasswordRequestBody changePasswordrequestBody) async {
    var response = await _apiClient.changePassword(changePasswordrequestBody);
    return response;
  }
}
