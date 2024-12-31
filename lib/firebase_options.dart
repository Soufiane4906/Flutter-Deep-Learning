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
    apiKey: 'AIzaSyAr5m5MRNgNHMjG9-eH997z-KEoGb8oHeY',
    appId: '1:309638807640:web:22a38fcc2ea0fcab568a2d',
    messagingSenderId: '309638807640',
    projectId: 'flutterproject-5305a',
    authDomain: 'flutterproject-5305a.firebaseapp.com',
    storageBucket: 'flutterproject-5305a.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB48aouk11vPakO7iSwR_4ExTTzxMOdd7E',
    appId: '1:309638807640:android:035d624d25d4e7a3568a2d',
    messagingSenderId: '309638807640',
    projectId: 'flutterproject-5305a',
    storageBucket: 'flutterproject-5305a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMM-uDdiuWz9NdWihELe7IzKuSTN8euEM',
    appId: '1:309638807640:ios:a4e2052261639ce6568a2d',
    messagingSenderId: '309638807640',
    projectId: 'flutterproject-5305a',
    storageBucket: 'flutterproject-5305a.firebasestorage.app',
    iosBundleId: 'com.example.flutterProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMM-uDdiuWz9NdWihELe7IzKuSTN8euEM',
    appId: '1:309638807640:ios:a4e2052261639ce6568a2d',
    messagingSenderId: '309638807640',
    projectId: 'flutterproject-5305a',
    storageBucket: 'flutterproject-5305a.firebasestorage.app',
    iosBundleId: 'com.example.flutterProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAr5m5MRNgNHMjG9-eH997z-KEoGb8oHeY',
    appId: '1:309638807640:web:8319a1b41bbf15f6568a2d',
    messagingSenderId: '309638807640',
    projectId: 'flutterproject-5305a',
    authDomain: 'flutterproject-5305a.firebaseapp.com',
    storageBucket: 'flutterproject-5305a.firebasestorage.app',
  );
}