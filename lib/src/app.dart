import 'dart:io';
import 'dart:math';

import 'package:conet/utils/textTheme.dart';
import 'package:conet/utils/theme.dart';
import 'package:conet/src/ui/introscreen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bottomNavigation/bottomNavigationBloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      BlocProvider.of<BottomNavigationBloc>(context).add(const PageRefreshed(index: 1));
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    BlocProvider.of<BottomNavigationBloc>(context).add(AppStarted());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KONET',
      theme: ThemeData(
        primaryColor: AppColor.whiteColor,
        textTheme: Platform.isAndroid ? ConetTextTheme.androidTextTheme : ConetTextTheme.iosTextTheme,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColor.primaryColor,
            statusBarIconBrightness: Brightness.light, //<-- For Android
            statusBarBrightness: Brightness.dark, //<-- For iOS
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
