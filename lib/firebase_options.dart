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
    apiKey: 'AIzaSyB3KHB6WjBDG5Gs7rQBaw9Es--10jiO8IQ',
    appId: '1:1092055557587:web:3937a273ba16ca2425bb26',
    messagingSenderId: '1092055557587',
    projectId: 'pexelsapp-c3a8b',
    authDomain: 'pexelsapp-c3a8b.firebaseapp.com',
    storageBucket: 'pexelsapp-c3a8b.firebasestorage.app',
    measurementId: 'G-9ERBPGRMXX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4h-r7kzPa_KqTh4QiPIF6uZYATb4giXU',
    appId: '1:1092055557587:android:eb5d4d0c3502722d25bb26',
    messagingSenderId: '1092055557587',
    projectId: 'pexelsapp-c3a8b',
    storageBucket: 'pexelsapp-c3a8b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAAyvlRSCt1nl749vou40SO6wjKsfH6kk',
    appId: '1:1092055557587:ios:63db22d6fb4ed60625bb26',
    messagingSenderId: '1092055557587',
    projectId: 'pexelsapp-c3a8b',
    storageBucket: 'pexelsapp-c3a8b.firebasestorage.app',
    iosBundleId: 'com.example.pexelsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCAAyvlRSCt1nl749vou40SO6wjKsfH6kk',
    appId: '1:1092055557587:ios:63db22d6fb4ed60625bb26',
    messagingSenderId: '1092055557587',
    projectId: 'pexelsapp-c3a8b',
    storageBucket: 'pexelsapp-c3a8b.firebasestorage.app',
    iosBundleId: 'com.example.pexelsApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB3KHB6WjBDG5Gs7rQBaw9Es--10jiO8IQ',
    appId: '1:1092055557587:web:ff444187d1f4252e25bb26',
    messagingSenderId: '1092055557587',
    projectId: 'pexelsapp-c3a8b',
    authDomain: 'pexelsapp-c3a8b.firebaseapp.com',
    storageBucket: 'pexelsapp-c3a8b.firebasestorage.app',
    measurementId: 'G-7LXKPPTZ52',
  );
}
