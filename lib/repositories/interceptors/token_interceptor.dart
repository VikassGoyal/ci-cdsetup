import 'package:conet/constants/constants.dart';
import 'package:conet/services/storage_service.dart';
import 'package:conet/utils/get_it.dart';
import 'package:dio/dio.dart';

///
///  Refresh token interceptor.
///
class TokenInterceptor extends QueuedInterceptor {
  TokenInterceptor({required this.dioClient});

  // Original dio client that invoked this request.
  final Dio dioClient;

  final dio = Dio(BaseOptions(
      connectTimeout: const Duration(milliseconds: 7000), receiveTimeout: const Duration(milliseconds: 7000)));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final authHeader = options.headers[kAuthHeaderRequired];

    // Automatically attach application/json as most of the requests are json body only.
    options.headers.addAll({'Content-Type': 'application/json'});
    options.headers.addAll({'Accept': 'application/json'});

    // If auth placeholder is present, then attach authorization header in requests.
    if (authHeader != null && authHeader == '1') {
      // Get access token.
      final accessToken = locator<StorageService>().getPrefs(kPrefAccessTokenKey, defaultValue: '')!;
      if (accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      } else {
        return handler.reject(DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          error: Exception('Access token required for this request.'),
        ));
      }

      // Remove helper header.
      options.headers.remove(kAuthHeaderRequired);
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
