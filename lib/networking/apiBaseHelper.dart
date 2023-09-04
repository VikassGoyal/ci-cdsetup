// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:conet/config/app_config.dart';
// import 'package:conet/utils/constant.dart';
// import 'package:conet/networking/apiExceptions.dart';
// import 'package:conet/utils/get_it.dart';


// import 'package:shared_preferences/shared_preferences.dart';

// class ApiBaseHelper {
//   //String _baseUrl = AppConstant.baseUrl;
//   // final String baseUrl = AppConstant.baseUrl;
//   String? serverHost = locator<AppConfig>().baseApiUrl;

//   Future postWithoutToken(String url, Map<String, dynamic> body) async {
//     print('Api Post, urll $url');
//     var responseJson;
//     try {
//       var uri = Uri.http(locator<AppConfig>().baseApiUrl, "api/$url");
//       final response = await http.post(uri, body: body);
//       responseJson = await _returnResponse(response);
//       print(responseJson);
//     } catch (error) {
//       print('api ptost.');
//       print('FetchDataException : $error');
//       throw FetchDataException('No Internet connection');
//     }
//     return responseJson;
//   }

//   Future get(String url) async {
//     SharedPreferences? preferences = await SharedPreferences.getInstance();
//     String? token = preferences.getString('token');
//     print(token);

//     var responseJson;
//     try {
//       var uri = Uri.http(locator<AppConfig>().baseApiUrl, "api/$url");
//       final response = await http.get(uri, headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       });
//       responseJson = await _returnResponse(response);
//     } catch (e) {
//       print('No net : $e');
//       throw FetchDataException('No Internet connection');
//     }
//     print('api get recieved!');
//     return responseJson;
//   }

//   Future post(String url, body) async {
//     SharedPreferences? preferences = await SharedPreferences.getInstance();
//     String? token = preferences.getString('token');
//     print('Api Post, url $url');
//     print(token);
//     print(jsonEncode(body));

//     var responseJson;
//     try {
//       var headers = {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       };

//       var uri = Uri.http(locator<AppConfig>().baseApiUrl, "api/$url");
//       final response = await http.post(uri, body: jsonEncode(body), headers: headers);

//       print(response.statusCode);
//       print(response.body);

//       responseJson = _returnResponse(response);
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//     print('api post.');
//     return responseJson;
//   }

//   Future put(String url, dynamic body) async {
//     print('Api Put, url $url');
//     var responseJson;
//     try {
//       var uri = Uri.http(locator<AppConfig>().baseApiUrl, "api/$url");
//       final response = await http.put(uri, body: body);
//       responseJson = _returnResponse(response);
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//     print('api put.');
//     print(responseJson.toString());
//     return responseJson;
//   }

//   Future delete(String url) async {
//     print('Api delete, url $url');
//     var apiResponse;
//     try {
//       var uri = Uri.http(locator<AppConfig>().baseApiUrl, "api/$url");
//       final response = await http.delete(uri);
//       apiResponse = _returnResponse(response);
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//     print('api delete.');
//     return apiResponse;
//   }
// }

// dynamic _returnResponse(http.Response response) async {
//   switch (response.statusCode) {
//     case 200:
//       var responseWithUrl = response.body.toString();
//       var responseJson = await jsonDecode(responseWithUrl);
//       return responseJson;
//     case 400:
//       throw BadRequestException(response.body.toString());
//     case 401:
//     case 403:
//       throw UnauthorisedException(response.body.toString());
//     case 500:
//     default:
//       throw FetchDataException(
//           'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
//   }
// }

