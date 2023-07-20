import 'package:conet/config/app_config.dart';
import 'package:conet/constants/enums.dart';
import 'package:conet/repositories/interceptors/token_interceptor.dart';
import 'package:conet/repositories/retrofit/api_client.dart';
import 'package:dio/dio.dart';

import '../api_models/totalCount_response_model copy/totalCount_response_body.dart';

import '../utils/get_it.dart';

class SettingsPageRepository {
  SettingsPageRepository() {
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

    print('SettingsPageRepository initialised');
  }

  late final ApiClient _apiClient;

  fetchTotalcountData() async {
    TotalCountResponse response = await _apiClient.totalcount();

    return response;
  }
}
