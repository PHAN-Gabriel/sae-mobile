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
    apiKey: 'AIzaSyAY5-npOKWaZtqWreeCkYmEA3urlP5g4WQ',
    appId: '1:1032186674550:web:1d949f6efa8aaefae14e57',
    messagingSenderId: '1032186674550',
    projectId: 'sae-mobile-article',
    authDomain: 'sae-mobile-article.firebaseapp.com',
    storageBucket: 'sae-mobile-article.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlfTngwa-uRLULbgUXTqB4TfRmlQWqmRw',
    appId: '1:1032186674550:android:d47a374680f95a9ce14e57',
    messagingSenderId: '1032186674550',
    projectId: 'sae-mobile-article',
    storageBucket: 'sae-mobile-article.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcEIUDDpQKZnFyj3BwUixbHRzeW7T9iuQ',
    appId: '1:1032186674550:ios:bc8dfb5670afe29ee14e57',
    messagingSenderId: '1032186674550',
    projectId: 'sae-mobile-article',
    storageBucket: 'sae-mobile-article.appspot.com',
    iosClientId: '1032186674550-brknhjdd9tpv55mc0hb3c1ndpuludpgq.apps.googleusercontent.com',
    iosBundleId: 'com.example.td22223',
  );
}
