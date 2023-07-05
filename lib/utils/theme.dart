import 'package:flutter/services.dart';

class AppColor {
  static const primaryColor = Color(0xFFFF931E);
  static const secondaryColor = Color(0xFF0087FB);
  static const accentColor = Color(0xFF1DD069);
  static const whiteColor = Color(0xFFFFFFFF);
  static const redColor = Color(0xFFE92200);
  static const blackColor = Color(0xFF000000);
  static const black2 = Color(0xFF3F3D56);
  static const black3 = Color(0xFF0F0A0C);
  static const subTitleColor = Color(0xFF3C3C43);
  static const textFieldBlueBgColor = Color(0xFF050632);
  static const textFieldBgColor = Color(0xFFF6F6F6);
  static const inputFieldBgColor = Color(0xFF050632);
  static const gray30Color = Color(0xFF9597A1);
  static const grey2 = Color(0xFF3C3C43);
  static const placeholder = Color(0xFF878B95);
  static const bottomNavBgColor = Color(0xFFF8F8F8);
  static const bottomUnselectItemColor = Color(0xFF757575);
  static const dividerItemColor = Color(0xFFD7D7D7);
  static const removeIconColor = Color(0xFFDE5753);
  static const SettingprofileIconColor = Color(0xFF0087FB);
  static const KonetwebsearchTextColor = Color(0xFF878B95);
  static const Alertheadingcolor = Color(0xFF3F3D56);
  static const Alertsubtitlecolor = Color(0xFF878B95);
  static const Companyprofilenumber = Color(0xff757575);
}

class StatusBarTheme {
  //status bar colors
  static const systemUiOverlayStyleOrange = SystemUiOverlayStyle(
    statusBarColor: AppColor.primaryColor,
    statusBarIconBrightness: Brightness.light, //<-- For Android
    statusBarBrightness: Brightness.dark, //<-- For iOS
  );

  static const systemUiOverlayStyleWhite = SystemUiOverlayStyle(
    statusBarColor: AppColor.whiteColor,
    statusBarIconBrightness: Brightness.dark, //<-- For Android
    statusBarBrightness: Brightness.light, //<-- For iOS
  );
}
