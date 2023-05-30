import 'dart:io';

import 'package:conet/src/homeScreen.dart';
import 'package:conet/src/ui/auth/forgotPassword.dart';
import 'package:conet/src/ui/auth/login.dart';
import 'package:conet/src/ui/auth/signup.dart';
import 'package:conet/src/ui/introscreen/introSlider.dart';
import 'package:conet/src/ui/keypadPage.dart';
import 'package:conet/src/ui/contactsPage.dart';
import 'package:conet/src/ui/recentPage.dart';
import 'package:conet/src/ui/settings/myprofile.dart';
import 'package:conet/src/ui/settings/settings.dart';
import 'package:conet/utils/textTheme.dart';
import 'package:conet/utils/theme.dart';
import 'package:conet/src/ui/introscreen/splashScreen.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoNet',
      home: Builder(
        builder: (context) {
          return KeypadPage();
        },
      ),
      theme: ThemeData(
        primaryColor: AppColor.whiteColor,
        textTheme: Platform.isAndroid ? ConetTextTheme.androidTextTheme : ConetTextTheme.iosTextTheme,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
