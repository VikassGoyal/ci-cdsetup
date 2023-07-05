import 'package:conet/constants/constants.dart';
import 'package:conet/repositories/userRepository.dart';
import 'package:conet/services/storage_service.dart';
import 'package:conet/utils/get_it.dart';

class UserBloc {
  UserRepository? userRepository;

  UserBloc() {
    userRepository = UserRepository();
  }

  login(requestBody) async {
    try {
      var response = await userRepository?.login(requestBody);

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

  signup(requestBody) async {
    try {
      var response = await userRepository?.signup(requestBody);
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

  changePassword(requestBody) async {
    try {
      var response = await userRepository?.changePassword(requestBody);
      print(response.toString());
      return response;
    } catch (e) {
      print(e);
    }
  }
}
