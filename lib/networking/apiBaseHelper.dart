import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:conet/utils/constant.dart';
import 'package:conet/networking/apiExceptions.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper {
  String _baseUrl = AppConstant.baseUrl;
  final String baseUrl = AppConstant.baseUrl;
  String? serverHost = 'http://conet.shade6.in/';

  Future postWithoutToken(String url, Map<String, dynamic> body) async {
    print('Api Post, urll $url');
    Map<String, dynamic> responseJson;
    try {
      var uri = Uri.http('conet.shade6.in', "api/$url");
      final response = await http.post(uri, body: body);
      responseJson = _returnResponse(response);
    } catch (error) {
      print('api ptost.');
      print('FetchDataException : $error');
      throw FetchDataException('No Internet connection');
    }
  }

  Future get(String url) async {
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    print(token);

    var responseJson;
    try {
      var uri = Uri.http('conet.shade6.in', "api/$url");
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      responseJson = await _returnResponse(response);
    } catch (e) {
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

      var uri = Uri.http('conet.shade6.in', "api/$url");
      final response = await http.post(uri, body: jsonEncode(body), headers: headers);
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
      var uri = Uri.http('conet.shade6.in', "api/$url");
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
      var uri = Uri.http('conet.shade6.in', "api/$url");
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

Future<Map<String, dynamic>> _returnResponse(http.Response response) async {
  print(response.statusCode);
  //print(response.body);
  switch (response.statusCode) {
    case 200:
      String name = response.body.toString();
      String val = {
        "status": true,
        "message": "success",
        "user": {
          "id": 5509,
          "user_id": 22,
          "code": "CNT5508",
          "name": "vikass",
          "email": "vikasgoyal8247@gmail.com",
          "phone": "2222238383",
          "type": "professional",
          "profile_image": null,
          "img": "\/qrcode\/CNT5508.svg",
          "qr_value": "ff5b3082-77e4-4db8-9902-162179625b18",
          "businesscard_logo": null,
          "status": "active",
          "company": "yes",
          "transanction_id": null,
          "created_at": "2023-06-06 11:16:44",
          "updated_at": "2023-06-06 11:16:44",
          "formFilled": 100,
          "personal": {
            "id": 5509,
            "contact_id": 5509,
            "img": null,
            "number": "2222238383",
            "secondary_phone": null,
            "email": "vikasgoyal8247@gmail.com",
            "d_o_b": null,
            "address_1": null,
            "address_2": null,
            "address_3": null,
            "city": null,
            "state": null,
            "country": null,
            "pincode": null,
            "landline": null,
            "keyword": null,
            "created_at": "2023-06-06 11:16:44",
            "updated_at": "2023-06-06 11:16:44"
          },
          "professional": null,
          "professional_list": [],
          "social": null
        },
        "token":
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9jb25ldC5zaGFkZTYuaW5cL2FwaVwvbG9naW4iLCJpYXQiOjE2ODYwNjExMTcsIm"
      }.toString();
      Map<String, dynamic> responseJson = await jsonDecode(val);
      print(responseJson.values);
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
