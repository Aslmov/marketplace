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
    apiKey: 'AIzaSyALq-t3VWnGNuUatBITQYPvbkypu-6isnw',
    appId: '1:210255862837:web:db1cc594ddbf531a70257c',
    messagingSenderId: '210255862837',
    projectId: 'gochap-577b0',
    authDomain: 'gochap-577b0.firebaseapp.com',
    databaseURL: 'https://gochap-577b0-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gochap-577b0.appspot.com',
    measurementId: 'G-2D38R1TV4P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTdnBO8O43lm2s4f9axd8pYW80rhIn-Hk',
    appId: '1:210255862837:android:0448afdf6da1fdf370257c',
    messagingSenderId: '210255862837',
    projectId: 'gochap-577b0',
    databaseURL: 'https://gochap-577b0-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gochap-577b0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWCVYl9nzfV3_Td6pkIrQgyxMRYWHVrq8',
    appId: '1:210255862837:ios:ba122a7d18a25c5870257c',
    messagingSenderId: '210255862837',
    projectId: 'gochap-577b0',
    databaseURL: 'https://gochap-577b0-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'gochap-577b0.appspot.com',
    androidClientId: '210255862837-2235nkqq9kfvp1tmt6istsm1n098p6jp.apps.googleusercontent.com',
    iosClientId: '210255862837-qk4elo1tlmfs12i37hrj594obk3f6rc9.apps.googleusercontent.com',
    iosBundleId: 'solutions.digiplay.gochapuser',
  );
}
