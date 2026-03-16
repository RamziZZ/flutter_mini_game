import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyApQCvylgzDJgcPJ3X-rxhXsnXlxN2m7H0',
    appId: '1:247621092702:web:06bd5485eb5a240ed63bcf',
    messagingSenderId: '247621092702',
    projectId: 'flutter-connect-c2016',
    authDomain: 'flutter-connect-c2016.firebaseapp.com',
    databaseURL: 'https://flutter-connect-c2016-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-connect-c2016.firebasestorage.app',
    measurementId: 'G-N5EPGM774S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMV6MLhAeqVIJ_-jurskJmCoQa9iUgNRQ',
    appId: '1:247621092702:android:548a8c7d95356e7ed63bcf',
    messagingSenderId: '247621092702',
    projectId: 'flutter-connect-c2016',
    databaseURL: 'https://flutter-connect-c2016-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-connect-c2016.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2-HdQvLpp4-elduJI5ZPY259LyQaR5Zg',
    appId: '1:247621092702:ios:a1804adab201ad4ed63bcf',
    messagingSenderId: '247621092702',
    projectId: 'flutter-connect-c2016',
    databaseURL: 'https://flutter-connect-c2016-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-connect-c2016.firebasestorage.app',
    iosBundleId: 'com.example.flutterGame',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2-HdQvLpp4-elduJI5ZPY259LyQaR5Zg',
    appId: '1:247621092702:ios:a1804adab201ad4ed63bcf',
    messagingSenderId: '247621092702',
    projectId: 'flutter-connect-c2016',
    databaseURL: 'https://flutter-connect-c2016-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-connect-c2016.firebasestorage.app',
    iosBundleId: 'com.example.flutterGame',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAtiBVWCNyNmVuSChKYx4SVqpONXhydJvQ',
    appId: '1:247621092702:web:21a8832c6f9560afd63bcf',
    messagingSenderId: '247621092702',
    projectId: 'flutter-connect-c2016',
    authDomain: 'flutter-connect-c2016.firebaseapp.com',
    databaseURL: 'https://flutter-connect-c2016-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-connect-c2016.firebasestorage.app',
    measurementId: 'G-96CHFHK2FW',
  );
}
