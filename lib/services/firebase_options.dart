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
          'https://whack-a-mole-c6d7f-default-rtdb.europe-west1.firebasedatabase.app',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDVM2hfw4pjUDTFL1L48gv4qhkRIjrqmwA',
    appId: '1:1095858212223:web:b5510d46f3dc3d0f4c5e4a',
    messagingSenderId: '1095858212223',
    projectId: 'whack-a-mole-c6d7f',
    authDomain: 'whack-a-mole-c6d7f.firebaseapp.com',
    storageBucket: 'whack-a-mole-c6d7f.firebasestorage.app',
    measurementId: 'G-28XB6JW6E5',
    databaseURL: 'https://whack-a-mole-c6d7f-default-rtdb.europe-west1.firebasedatabase.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAV-aps31_1YXY1ZFIi_3zwAA7IqdqxvmM',
    appId: '1:1095858212223:android:bb41f53744975f044c5e4a',
    messagingSenderId: '1095858212223',
    projectId: 'whack-a-mole-c6d7f',
    storageBucket: 'whack-a-mole-c6d7f.firebasestorage.app',
    databaseURL: 'https://whack-a-mole-c6d7f-default-rtdb.europe-west1.firebasedatabase.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxzGe1R70ML_YYJ0cieSXBam7XqDWP_Bg',
    appId: '1:1095858212223:ios:7a88489d91b958e94c5e4a',
    messagingSenderId: '1095858212223',
    projectId: 'whack-a-mole-c6d7f',
    storageBucket: 'whack-a-mole-c6d7f.firebasestorage.app',
    iosBundleId: 'com.example.whackAMole',
    databaseURL: 'https://whack-a-mole-c6d7f-default-rtdb.europe-west1.firebasedatabase.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDxzGe1R70ML_YYJ0cieSXBam7XqDWP_Bg',
    appId: '1:1095858212223:ios:7a88489d91b958e94c5e4a',
    messagingSenderId: '1095858212223',
    projectId: 'whack-a-mole-c6d7f',
    storageBucket: 'whack-a-mole-c6d7f.firebasestorage.app',
    iosBundleId: 'com.example.whackAMole',
    databaseURL: 'https://whack-a-mole-c6d7f-default-rtdb.europe-west1.firebasedatabase.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDVM2hfw4pjUDTFL1L48gv4qhkRIjrqmwA',
    appId: '1:1095858212223:web:34e30399a373742d4c5e4a',
    messagingSenderId: '1095858212223',
    projectId: 'whack-a-mole-c6d7f',
    authDomain: 'whack-a-mole-c6d7f.firebaseapp.com',
    storageBucket: 'whack-a-mole-c6d7f.firebasestorage.app',
    measurementId: 'G-SYDRKSGN2T',
    databaseURL: 'https://whack-a-mole-c6d7f-default-rtdb.europe-west1.firebasedatabase.app',
  );
}


