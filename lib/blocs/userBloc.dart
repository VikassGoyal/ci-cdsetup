import 'package:conet/repositories/userRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc {
  UserRepository? userRepository;

  UserBloc() {
    userRepository = UserRepository();
  }

  login(requestBody) async {
    try {
      var response = await userRepository?.login(requestBody);
      if (response['message'] == 'success') {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', response['token']);
        preferences.setString('id', response['user']['user_id'].toString());
        preferences.setInt('formFilled', response['user']['formFilled']);
        preferences.setString('name', response['user']['name']);
        preferences.setString('email', response['user']['email']);
        preferences.setString('phone', response['user']['phone'].toString());
        preferences.setString('image', response['user']['img']);
        preferences.setBool('imported', false);
      }
      return response;
    } catch (e) {
      print(e);
    }
  }

  signup(requestBody) async {
    try {
      var response = await userRepository?.signup(requestBody);
      print(response.toString());
      if (response['status'] == true) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', response['token']);
        preferences.setString('id', response['user']['user_id'].toString());
        preferences.setInt('formFilled', response['user']['formFilled']);
        preferences.setString('name', response['user']['name']);
        preferences.setString('email', response['user']['email']);
        preferences.setString('phone', response['user']['phone'].toString());
        preferences.setString('image', response['user']['img']);
        preferences.setBool('imported', false);
      }
      return response;
    } catch (e) {
      print(e);
    }
  }

  otpVerification(requestBody) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var response = await userRepository?.otpVerification(requestBody);

      print("response: - ${response['message']}");
      if (response['message'] == 'success') {
        preferences.setString('token', response['token']);
        preferences.setString('id', response['user']['user_id'].toString());
        preferences.setInt('formFilled', response['user']['formFilled']);
        preferences.setString('name', response['user']['name']);
        preferences.setString('email', response['user']['email']);
        preferences.setString('phone', response['user']['phone'].toString());
        preferences.setString('image', response['user']['img']);
        preferences.setBool('imported', false);

        // if (response['user']['personal'] != null) {
        //   preferences.setString('dob', response['user']['personal']['d_o_b']);
        //   preferences.setString(
        //       'add', response['user']['personal']['address_1']);
        //   preferences.setString(
        //       'lan', response['user']['personal']['landline'].toString());
        // } else {
        //   preferences.setString('dob', 'null');
        //   preferences.setString('add', 'null');
        //   preferences.setString('lan', 'null');
        // }

        // if (response['user']['professional'] != null) {
        //   preferences.setString(
        //       'occupation', response['user']['professional']['occupation']);
        //   preferences.setString(
        //       'industry', response['user']['professional']['industry']);
        //   preferences.setString(
        //       'company', response['user']['professional']['company']);
        //   preferences.setString('school_university',
        //       response['user']['professional']['school_university']);
        //   preferences.setString(
        //       'grade', response['user']['professional']['grade']);
        //   preferences.setString(
        //       'work_nature', response['user']['professional']['work_nature']);
        //   preferences.setString(
        //       'designation', response['user']['professional']['designation']);

        //   preferences.setString('professional_list',
        //       json.encode(response['user']['professional_list']));
        // } else {
        //   preferences.setString('occupation', 'null');
        //   preferences.setString('industry', 'null');
        //   preferences.setString('company', 'null');
        //   preferences.setString('school_university', 'null');
        //   preferences.setString('grade', 'null');
        //   preferences.setString('work_nature', 'null');
        //   preferences.setString('designation', 'null');
        // }

        // if (response['user']['social'] != null) {
        //   preferences.setString(
        //       'facebook', response['user']['social']['facebook']);
        //   preferences.setString(
        //       'instagram', response['user']['social']['instagram']);
        //   preferences.setString(
        //       'twitter', response['user']['social']['twitter']);
        //   preferences.setString('skype', response['user']['social']['skype']);
        //   preferences.setString('gpay', response['user']['social']['gpay']);
        //   preferences.setString('paytm', response['user']['social']['paytm']);
        // } else {
        //   preferences.setString('facebook', 'null');
        //   preferences.setString('instagram', 'null');
        //   preferences.setString('twitter', 'null');
        //   preferences.setString('skype', 'null');
        //   preferences.setString('gpay', 'null');
        //   preferences.setString('paytm', 'null');
        // }
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
