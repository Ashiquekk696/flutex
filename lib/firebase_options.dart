// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA7uuhtHcPvi7by_Pzp4ifmKtLnHtcqyKw',
    appId: '1:399804051572:web:5a5ffda0c27c87a640a121',
    messagingSenderId: '399804051572',
    projectId: 'fir-learning-b5ef1',
    authDomain: 'fir-learning-b5ef1.firebaseapp.com',
    storageBucket: 'fir-learning-b5ef1.firebasestorage.app',
    measurementId: 'G-WKLCRM1SC1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8CQBgOPwc2m5dL8sFviq1D7aYE_Gw8ao',
    appId: '1:399804051572:android:1ea4cfb9ef5408fd40a121',
    messagingSenderId: '399804051572',
    projectId: 'fir-learning-b5ef1',
    storageBucket: 'fir-learning-b5ef1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdAdFw5QTAcyMMg4qKqTUYyhJEE40tsVY',
    appId: '1:399804051572:ios:dc7acf5566ce68d140a121',
    messagingSenderId: '399804051572',
    projectId: 'fir-learning-b5ef1',
    storageBucket: 'fir-learning-b5ef1.firebasestorage.app',
    iosClientId: '399804051572-n1ajd0vpjb57dveijuhgn4s17nnsbga7.apps.googleusercontent.com',
    iosBundleId: 'com.flutex.admin',
  );
}