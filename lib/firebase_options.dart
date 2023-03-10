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
    apiKey: 'AIzaSyAK3toPw3j0vOP0nUSMnCeqii8RRDUyJCU',
    appId: '1:312881501222:web:179d0cf59711e4f4d682e7',
    messagingSenderId: '312881501222',
    projectId: 'instagram-7de4c',
    authDomain: 'instagram-7de4c.firebaseapp.com',
    storageBucket: 'instagram-7de4c.appspot.com',
    measurementId: 'G-PKPS44QHGN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDasSYsL88-5Dgz6pzJm0nKEWDD-Iyg7Lc',
    appId: '1:312881501222:android:a8612b1af1aebd99d682e7',
    messagingSenderId: '312881501222',
    projectId: 'instagram-7de4c',
    storageBucket: 'instagram-7de4c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2mSVSSiFJ3X6l0uLYICHTn_EM3fSChak',
    appId: '1:312881501222:ios:ded84346293de19bd682e7',
    messagingSenderId: '312881501222',
    projectId: 'instagram-7de4c',
    storageBucket: 'instagram-7de4c.appspot.com',
    iosClientId: '312881501222-jrr2mp497gnli7i45bqpgkfpibnsc9it.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagramFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2mSVSSiFJ3X6l0uLYICHTn_EM3fSChak',
    appId: '1:312881501222:ios:ded84346293de19bd682e7',
    messagingSenderId: '312881501222',
    projectId: 'instagram-7de4c',
    storageBucket: 'instagram-7de4c.appspot.com',
    iosClientId: '312881501222-jrr2mp497gnli7i45bqpgkfpibnsc9it.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagramFlutter',
  );
}
