import 'package:conet/config/app_config.dart';
import 'package:conet/src/ui/auth/login.dart';
import 'package:conet/utils/get_it.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstant {
  static String url = locator<AppConfig>().baseApiUrl;
  // static String url = 'http://192.168.1.2/conet/public/';

  static String baseUrl = '$url/api/';
  static String imageBaseUrl = '$url/storage/uploads/';
  static String businessimageBaseUrl = '$url/storage/businesscardlogo/';
  static String profileImageBaseUrl = '$url/storage/profileimages/';
  static String serverHost = url;
}

Size displaySize(BuildContext context) {
  debugPrint('Size = ${MediaQuery.of(context).size}');
  return MediaQuery.of(context).size;
}

// double displayHeight(BuildContext context) {
//   debugPrint('Height = ${displaySize(context).height}');
//   return displaySize(context).height;
// }

double displayWidth(BuildContext context) {
  debugPrint('Width = ${displaySize(context).width}');
  return displaySize(context).width;
}

getTrimedNumber(number) {
  // var contactNumber = number
  //     .replaceAll(' ', '')
  //     .substring(number.replaceAll(' ', '').length - 10);
  if (number == null) return null;
  var numberspace = number.replaceAll(' ', '');
  var contactNumber = numberspace.substring(numberspace.length - 10);

  return contactNumber;
}

tokenExpired(context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();

  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => Login()),
    (Route<dynamic> route) => false,
  );
}

getDateFormat(date) {
  String formattedDate = '';
  try {
    var matchDate = DateFormat("yyyy-MM-dd hh:mm").parse(date);
    final DateFormat formatter = DateFormat('yMMMd');
    formattedDate = formatter.format(matchDate);
    return formattedDate;
  } catch (e) {
    print(e);
    return formattedDate;
  }
}

extension Validator on String {
  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(this);
  }

  bool isValidMobile() {
    return RegExp(r"^[0-9]{10}$").hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(r"^(?!.* )(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$").hasMatch(this);
  }
}
