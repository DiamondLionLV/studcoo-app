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
    apiKey: 'AIzaSyBqhPMiwsE18HAeXsrH_U7Td0BcSJAQbJ4',
    appId: '1:684211004402:web:ef0fe905a0c86832f5c16b',
    messagingSenderId: '684211004402',
    projectId: 'studcoo',
    authDomain: 'studcoo.firebaseapp.com',
    storageBucket: 'studcoo.appspot.com',
    measurementId: 'G-WLJWS7TR2W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAhnul8KMnubRII7q4aCkDG_axn6xBv4U',
    appId: '1:684211004402:android:47b78fda1cfd3f66f5c16b',
    messagingSenderId: '684211004402',
    projectId: 'studcoo',
    storageBucket: 'studcoo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvRelbyTbHutAcTkC0ys8CESnY1zInEXc',
    appId: '1:684211004402:ios:2d52a7fddda2e885f5c16b',
    messagingSenderId: '684211004402',
    projectId: 'studcoo',
    storageBucket: 'studcoo.appspot.com',
    iosClientId: '684211004402-38hibecc16e4ijle4jvlie8st039a3go.apps.googleusercontent.com',
    iosBundleId: 'com.studcoo.studcooapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvRelbyTbHutAcTkC0ys8CESnY1zInEXc',
    appId: '1:684211004402:ios:4a1cb03718e287e4f5c16b',
    messagingSenderId: '684211004402',
    projectId: 'studcoo',
    storageBucket: 'studcoo.appspot.com',
    iosClientId: '684211004402-b70dit8j1ceqt7a8tmebnbph2o9pj2ho.apps.googleusercontent.com',
    iosBundleId: 'com.example.studcoo',
  );
}
