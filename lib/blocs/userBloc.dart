import 'package:conet/constants/constants.dart';
import 'package:conet/api_models/login_request_body/login_request_body.dart';
import 'package:conet/api_models/signup_request_body/signup_request_body.dart';
import 'package:conet/repositories/userRepository.dart';
import 'package:conet/services/storage_service.dart';
import 'package:conet/utils/get_it.dart';

import '../api_models/changepassword_request_model/changepassword_request_body.dart';
import '../api_models/forgotpassword__request_model/forgotpassword_request_body.dart';

class UserBloc {
  UserRepository? userRepository;

  UserBloc() {
    userRepository = UserRepository();
  }

  login({required String email, required String password}) async {
    try {
      var response = await userRepository?.login(LoginRequestBody(email: email, password: password));

      print(response['message']);
      if (response['message'] == "success") {
        final prefs = locator<StorageService>();
        prefs.setPrefs<String>(kPrefAccessTokenKey, response['token']);
        prefs.setPrefs<String>('id', response['user']['user_id'].toString());
        prefs.setPrefs<int>('formFilled', response['user']['formFilled']);
        prefs.setPrefs<String>('name', response['user']['name']);
        prefs.setPrefs<String>('email', response['user']['email']);
        prefs.setPrefs<String>('phone', response['user']['phone'].toString());
        prefs.setPrefs<String>('image', response['user']['img']);
        prefs.setPrefs<bool>('imported', false);
      }
      return response;
    } catch (e) {
      print("error");
    }
  }

  signup({required String username, required String email, required String phone, required String password}) async {
    try {
      var response = await userRepository
          ?.signup(SignupRequestBody(username: username, email: email, phone: phone, password: password));
      print(response.toString());
      if (response['status'] == true) {
        final prefs = locator<StorageService>();
        prefs.setPrefs<String>(kPrefAccessTokenKey, response['token']);
        prefs.setPrefs<String>('id', response['user']['user_id'].toString());
        prefs.setPrefs<int>('formFilled', response['user']['formFilled']);
        prefs.setPrefs<String>('name', response['user']['name']);
        prefs.setPrefs<String>('email', response['user']['email']);
        prefs.setPrefs<String>('phone', response['user']['phone'].toString());
        prefs.setPrefs<String>('image', response['user']['img']);
        prefs.setPrefs<bool>('imported', false);
      }
      return response;
    } catch (e) {
      print(e);
    }
  }

  changePassword(ChangePasswordRequestBody changePasswordrequestBody) async {
    try {
      var response = await userRepository?.changePassword(changePasswordrequestBody);
      print(response.toString());
      return response;
    } catch (e) {
      print(e);
    }
  }

  forgotPassword(ForgotpasswordRequestBody forgotpasswordRequestBody) async {
    try {
      var response = await userRepository?.forgotPassword(forgotpasswordRequestBody);
      print(response.toString());
      return response;
    } catch (e) {
      print(e);
    }
  }
}
