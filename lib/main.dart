import 'dart:async';

import 'package:conet/blocs/recent_calls/recent_calls_bloc.dart';
import 'package:conet/repositories/coNetWebPageRepository.dart';
import 'package:conet/repositories/contactPageRepository.dart';
import 'package:conet/repositories/keypadPageRepository.dart';
import 'package:conet/repositories/recentPageRepository.dart';
import 'package:conet/repositories/settingsPageRepository.dart';
import 'package:conet/services/storage_service.dart';
import 'package:conet/src/localdb/database_helper.dart';
import 'package:conet/utils/get_it.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bottomNavigation/bottomNavigationBloc.dart';
import 'firebase_options.dart';
import 'src/app.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Bloc.observer = SimpleBlocObserver();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Register getIt dependencies.
    registerServicesWithGetIt();

    // Initializing FlutterFire
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    await locator<StorageService>().init();

    // Initialise SQLite database.
    await DatabaseHelper.instance.initialize();

    // Catch uncaught errors from Flutter framework.
    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      // Dump errors to console in debug mode, else to crashlytics.
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(errorDetails);
      } else {
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };

    // Run the application.
    runApp(const App());
  },
      // Catch all asynchronous exceptions not handled by Flutter framework.
      (error, stack) {
    print("MainApp : runZonedGuarded : $error");
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<BottomNavigationBloc>(
                create: (context) => BottomNavigationBloc(
                      contactPageRepository: ContactPageRepository(),
                      keypadPageRepository: KeypadPageRepository(),
                      conetWebPageRepository: CoNetWebPageRepository(),
                      settingsPageRepository: SettingsPageRepository(),
                    )..add(AppStarted())),
            BlocProvider<RecentCallsBloc>(
                create: (context) => RecentCallsBloc(recentPageRepository: RecentPageRepository())),
          ],
          child: Builder(
            builder: (context) {
              return const MyApp();
            },
          ),
        );
      },
    );
  }
}
