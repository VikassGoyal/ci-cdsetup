// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBuk0HVTGlLaHHFYRQF0FQ9tswUOFQ0SZ4',
    appId: '1:968842320717:android:216a01a04be22c98aef504',
    messagingSenderId: '968842320717',
    projectId: 'conet-26772',
    storageBucket: 'conet-26772.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASnFyyZzNTBMJ_zG_qg1mu-dJpC4gosuA',
    appId: '1:968842320717:ios:29cedbe401691b2caef504',
    messagingSenderId: '968842320717',
    projectId: 'conet-26772',
    storageBucket: 'conet-26772.appspot.com',
    androidClientId: '968842320717-9lj5u6eqfroorpjl2ru8t091fiv4vghe.apps.googleusercontent.com',
    iosClientId: '968842320717-k05takhag7cfmeoe5v91ffqjjjgbon4s.apps.googleusercontent.com',
    iosBundleId: 'com.konet.in',
  );
}
