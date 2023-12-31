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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBgTZgDBd2763DK_hcrTdB_8uNiEUVFsxc',
    appId: '1:367734674311:web:2a90bf0fee6da6f265b922',
    messagingSenderId: '367734674311',
    projectId: 'flutter-tranning',
    authDomain: 'flutter-tranning.firebaseapp.com',
    databaseURL: 'https://flutter-tranning-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-tranning.appspot.com',
    measurementId: 'G-6JTP931WEZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPfWmN_q4Vr4bAIRpWvGQZbcbA8AKn6Yo',
    appId: '1:367734674311:android:a348ce753235cfcf65b922',
    messagingSenderId: '367734674311',
    projectId: 'flutter-tranning',
    databaseURL: 'https://flutter-tranning-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-tranning.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADQS_JaRbl2yEVjBGTb_E434zr4KGqo6I',
    appId: '1:367734674311:ios:86df76a822e1e80865b922',
    messagingSenderId: '367734674311',
    projectId: 'flutter-tranning',
    databaseURL: 'https://flutter-tranning-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-tranning.appspot.com',
    iosBundleId: 'com.example.firebaseDbApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADQS_JaRbl2yEVjBGTb_E434zr4KGqo6I',
    appId: '1:367734674311:ios:6027171888caca5665b922',
    messagingSenderId: '367734674311',
    projectId: 'flutter-tranning',
    databaseURL: 'https://flutter-tranning-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-tranning.appspot.com',
    iosBundleId: 'com.example.firebaseDbApp.RunnerTests',
  );
}
