import 'dart:io';

import 'package:conet/bottomNavigation/bottomNavigationBloc.dart';
import 'package:conet/utils/textTheme.dart';
import 'package:conet/utils/theme.dart';
import 'package:conet/repositories/repositories.dart';
import 'package:conet/src/appScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoNet',
      home: BlocProvider<BottomNavigationBloc>(
        create: (context) => BottomNavigationBloc(
          contactPageRepository: ContactPageRepository(),
          recentPageRepository: RecentPageRepository(),
          keypadPageRepository: KeypadPageRepository(),
          conetWebPageRepository: CoNetWebPageRepository(),
          settingsPageRepository: SettingsPageRepository(),
        )..add(AppStarted()),
        child: const AppScreen(),
      ),
      theme: ThemeData(
        primaryColor: AppColor.whiteColor,
        textTheme: Platform.isAndroid
            ? ConetTextTheme.androidTextTheme
            : ConetTextTheme.iosTextTheme,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
