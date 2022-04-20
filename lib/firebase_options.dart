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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD713HklIV2tyd50zsqgPXsCE1bzGCVjx0',
    appId: '1:630081678947:android:84d2423eda0af3572e9256',
    messagingSenderId: '630081678947',
    projectId: 'orc-hr-hamwi',
    storageBucket: 'orc-hr-hamwi.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1-aavujA0gsEBmo-mdEzlhOEu-AtEYj4',
    appId: '1:630081678947:ios:05268a266db133f92e9256',
    messagingSenderId: '630081678947',
    projectId: 'orc-hr-hamwi',
    storageBucket: 'orc-hr-hamwi.appspot.com',
    iosClientId: '630081678947-r78t46jm74a5r8e57oako99pu6ks5crm.apps.googleusercontent.com',
    iosBundleId: 'com.orchr.hamwi',
  );
}