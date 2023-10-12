import 'dart:io';

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
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late final BottomNavigationBloc bottomNavigationBloc;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      if (bottomNavigationBloc.getIsAppLifecycleStateIsPausedValue()) {
        print('------------> AppLifecycle changed after paused to : resumed');
        bottomNavigationBloc.setIsAppLifecycleStateIsPausedValue(false);
        print('------------> adding PageRefreshed event in didChangeAppLifecycleState of MyApp');
        bottomNavigationBloc.add(const PageRefreshed(index: 0));
      }
    }
    if (state == AppLifecycleState.paused) {
      print('------------> AppLifecycle changed to : paused');
      bottomNavigationBloc.setIsAppLifecycleStateIsPausedValue(true);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    bottomNavigationBloc = BlocProvider.of<BottomNavigationBloc>(context);
    print('------------> adding AppStarted event in initState of MyApp');
    bottomNavigationBloc.add(AppStarted());
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
