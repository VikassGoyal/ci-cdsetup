import 'dart:async';

import 'package:conet/api_models/getProfileDetails_request_model/getProfileDetails_request_body.dart';
import 'package:conet/blocs/contactBloc.dart';
import 'package:conet/bottomNavigation/bottomNavigationBloc.dart';
import 'package:conet/constants/constants.dart';
import 'package:conet/services/storage_service.dart';
import 'package:conet/src/homeScreen.dart';
import 'package:conet/src/localdb/database_helper.dart';
import 'package:conet/src/ui/auth/login.dart';
import 'package:conet/src/ui/introscreen/introSlider.dart';
import 'package:conet/src/ui/utils.dart';
import 'package:conet/utils/check_internet_connection.dart';
import 'package:conet/utils/custom_fonts.dart';
import 'package:conet/utils/get_it.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print("eeeeeeee");
    startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, //for status bar colors
      //since there is no appBar used here so to give proper colors to the status bar, we used the AnnotatedRegion
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.primaryColor,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.35),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/logo.svg",
                    color: Colors.white,
                    height: 47,
                  ),
                  const SizedBox(width: 15),
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      'KONET',
                      style: TextStyle(
                        fontFamily: kDreadnoughtusFontFamily,
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset("assets/images/splashbottompng.png"),
            )
          ],
        ),
      ),
    );
  }

  startTimer() {
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  logoutAfterSplash() async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    await databaseHelper.trancateAllContacts();
    await databaseHelper.trancateRecentContacts();
    BlocProvider.of<BottomNavigationBloc>(context).getRemoveContactData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }

  //This function is to check whether the account is permanently deleted or not
  //call this function only when you have access_token in shared_preferences
  Future<bool> doesUserExist() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String phonenum = preferences.getString("phone") ?? "";
      bool hasInternet = await checkInternetConnection();
      if (hasInternet) {
        var response = await ContactBloc().getProfileDetails(GetProfileDetailsRequestBody(phone: phonenum));
        // print('status : ${response['status']} and message : ${response['message']}');
        // if (response != null && response['status'] == false && response['message'] == "No User Available") {
        //   return false;
        // }
        if (response == null) {
          return false;
        }
      } else {
        await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text: "Please check your internet connection",
            onConfirmBtnTap: () {
              startTimer();
            });
      }
    } catch (e) {
      bool hasInternet = await checkInternetConnection();
      print(e);
      Utils.displayToastBottomError(hasInternet ? e.toString() : "Please check your internet connection", context);
    }
    return true;
  }

  Future<void> navigationPage() async {
    print("ewwwwww");
    if (locator<StorageService>().getPrefs(kPrefAccessTokenKey) != null) {
      if (await doesUserExist()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        //perform logout
        logoutAfterSplash();
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IntroSliderScreen()),
      );
    }
  }
}
