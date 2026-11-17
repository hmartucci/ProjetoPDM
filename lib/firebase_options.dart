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
    apiKey: 'AIzaSyChcasyVLLLdhQDFvZqnIk9lELMfnXU-n0',
    appId: '1:783449552405:web:93dec15cbc259a347c801c',
    messagingSenderId: '783449552405',
    projectId: 'app-manutencaocarro',
    authDomain: 'app-manutencaocarro.firebaseapp.com',
    storageBucket: 'app-manutencaocarro.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcN7fm-4BsbQ1VwhfOPBlDM_Jx4QbrjGI',
    appId: '1:783449552405:android:0edd629c9e3b595c7c801c',
    messagingSenderId: '783449552405',
    projectId: 'app-manutencaocarro',
    storageBucket: 'app-manutencaocarro.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZoZ7qeFhoJ6OdULw_JajAvsHXd96x_DM',
    appId: '1:783449552405:ios:322ff1c7ed4bd5457c801c',
    messagingSenderId: '783449552405',
    projectId: 'app-manutencaocarro',
    storageBucket: 'app-manutencaocarro.firebasestorage.app',
    iosBundleId: 'com.example.p1',
  );
}
