import 'dart:io';

import 'package:conet/utils/textTheme.dart';
import 'package:conet/utils/theme.dart';
import 'package:conet/src/appScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KoNet',
      home: AppScreen(),
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
