import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
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
    Bloc.observer = SimpleBlocObserver();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    WidgetsFlutterBinding.ensureInitialized();

    // Initializing FlutterFire
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // FirebaseCrashlytics.instance.crash();

    // Pass all uncaught errors from the framework to Crashlytics.
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(const App());
  }, (error, stack) {
    print("MainApp : runZonedGuarded : $error");
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}
