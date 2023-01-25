import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:conet/utils/constant.dart';
import 'package:conet/networking/apiExceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper {
  // String _baseUrl = AppConstant.baseUrl;
  final String baseUrl = AppConstant.baseUrl;
  String? serverHost = 'http://conet.shadesix.in/';

  Future postWithoutToken(String url, Map<String, dynamic> body) async {
    print('Api Post, url $url');
    var responseJson;
    try {
      var uri = Uri.http('conet.shadesix.in', "api/$url");
      final response = await http.post(uri, body: body);
      responseJson = _returnResponse(response);
    } catch(error) {
      print('FetchDataException : $error');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future get(String url) async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    print(token);

    var responseJson;
    try {
      var uri = Uri.http('conet.shadesix.in', "api/$url");
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      responseJson = await _returnResponse(response);
    } catch(e) {
      print('No net : $e');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future post(String url, body) async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    print('Api Post, url $url');
    print(token);
    print(jsonEncode(body));

    var responseJson;
    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      var uri = Uri.http('conet.shadesix.in', "api/$url");
      final response = await http.post(uri,
          body: jsonEncode(body), headers: headers);
      print(response);

      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future put(String url, dynamic body) async {
    print('Api Put, url $url');
    var responseJson;
    try {
      var uri = Uri.http('conet.shadesix.in', "api/$url");
      final response = await http.put(uri, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future delete(String url) async {
    print('Api delete, url $url');
    var apiResponse;
    try {
      var uri = Uri.http('conet.shadesix.in', "api/$url");
      final response = await http.delete(uri);
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  print(response);
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
