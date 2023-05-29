import 'dart:async';

import 'package:conet/src/homeScreen.dart';
import 'package:conet/src/ui/introscreen/introSlider.dart';
import 'package:conet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // initializeFlutterFire();
    super.initState();
    startTimer();
  }

  // FlutterFire Initialization
  // void initializeFlutterFire() async {
  //   try {
  //     await Firebase.initializeApp();
  //     print("FlutterFire Initialization successfully");
  //   } catch (e) {
  //     print("FlutterFire Initialization error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.primaryColor,
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.width * 0.85,
            child: SvgPicture.asset("assets/logo.svg"),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset("assets/images/splashbottompng.png"),
          )
        ],
      ),
    );
  }

  startTimer() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getString("token") != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IntroSliderScreen()),
      );
    }
  }
}
