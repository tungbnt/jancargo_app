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
    apiKey: 'AIzaSyAyNtn_VSL1Dzdh8Pz99p2rvyS6pISaNKw',
    appId: '1:752146750596:web:43077f3b2559d0040df6d1',
    messagingSenderId: '752146750596',
    projectId: 'test-phone-auth-5ff03',
    authDomain: 'test-phone-auth-5ff03.firebaseapp.com',
    databaseURL: 'https://test-phone-auth-5ff03.firebaseio.com',
    storageBucket: 'test-phone-auth-5ff03.appspot.com',
    measurementId: 'G-L0TVZVBBWF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClIGloInN6CSSrT8IOzxLinIxQab0-d9U',
    appId: '1:752146750596:android:e5f40775a7fa417c0df6d1',
    messagingSenderId: '752146750596',
    projectId: 'test-phone-auth-5ff03',
    databaseURL: 'https://test-phone-auth-5ff03.firebaseio.com',
    storageBucket: 'test-phone-auth-5ff03.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChRGphdMgxK0vFOmU41D4rgXZ4LCQbImc',
    appId: '1:752146750596:ios:1261b7ab9cb1a7460df6d1',
    messagingSenderId: '752146750596',
    projectId: 'test-phone-auth-5ff03',
    databaseURL: 'https://test-phone-auth-5ff03.firebaseio.com',
    storageBucket: 'test-phone-auth-5ff03.appspot.com',
    iosBundleId: 'com.app.jancargo.jancargoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChRGphdMgxK0vFOmU41D4rgXZ4LCQbImc',
    appId: '1:752146750596:ios:1261b7ab9cb1a7460df6d1',
    messagingSenderId: '752146750596',
    projectId: 'test-phone-auth-5ff03',
    databaseURL: 'https://test-phone-auth-5ff03.firebaseio.com',
    storageBucket: 'test-phone-auth-5ff03.appspot.com',
    iosBundleId: 'com.app.jancargo.jancargoApp',
  );
}
