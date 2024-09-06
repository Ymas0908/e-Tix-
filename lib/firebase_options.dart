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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDvavhUgJez18DYhuBbItV_IO-YJ5-SnPU',
    appId: '1:1080211718464:android:e57b8a4c9e2b42635e7aa5',
    messagingSenderId: '1080211718464',
    projectId: 'firebase-auth-007',
    authDomain: 'fir-auth-007-83338.firebaseapp.com',
    storageBucket: 'firebase-auth-007.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvavhUgJez18DYhuBbItV_IO-YJ5-SnPU',
    appId: '1:1080211718464:android:e57b8a4c9e2b42635e7aa5',
    messagingSenderId: '1080211718464',
    projectId: 'firebase-auth-007',
    storageBucket: 'firebase-auth-007.appspot.com',
    authDomain: 'fir-auth-007-83338.firebaseapp.com',

  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvavhUgJez18DYhuBbItV_IO-YJ5-SnPU',
    appId: '1:1080211718464:android:e57b8a4c9e2b42635e7aa5',
    messagingSenderId: '1080211718464',
    projectId: 'firebase-auth-007',
    storageBucket: 'firebase-auth-007.appspot.com',
    iosBundleId: 'com.example.authFirebase',
    authDomain: 'fir-auth-007-83338.firebaseapp.com',

  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvavhUgJez18DYhuBbItV_IO-YJ5-SnPU',
    appId: '1:1080211718464:android:e57b8a4c9e2b42635e7aa5',
    messagingSenderId: '1080211718464',
    projectId: 'firebase-auth-007',
    storageBucket: 'firebase-auth-007.appspot.com',
    iosBundleId: 'com.example.authFirebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDvavhUgJez18DYhuBbItV_IO-YJ5-SnPU',
    appId: '1:1080211718464:android:e57b8a4c9e2b42635e7aa5',
    messagingSenderId: '1080211718464',
    projectId: 'firebase-auth-007',
    authDomain: 'fir-auth-007-83338.firebaseapp.com',
    storageBucket: 'firebase-auth-007.appspot.com',
  );
}