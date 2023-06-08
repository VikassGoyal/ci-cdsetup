import 'package:conet/networking/apiBaseHelper.dart';

class UserRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  login(requestBody) async {
    var response = await _apiBaseHelper.postWithoutToken("login", requestBody);

    return response;
  }

  signup(requestBody) async {
    var response = await _apiBaseHelper.postWithoutToken("signup", requestBody);
    return response;
  }

  otpVerification(requestBody) async {
    var response = await _apiBaseHelper.postWithoutToken("loginwithotp", requestBody);
    return response;
  }

  changePassword(requestBody) async {
    var response = await _apiBaseHelper.post("changepassword", requestBody);
    return response;
  }
}
