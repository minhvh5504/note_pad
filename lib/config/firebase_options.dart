import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

FirebaseOptions firebaseOptionsFromEnv() {
  final projectId = dotenv.get("FIREBASE_PROJECT_ID");
  final storageBucket = dotenv.get("FIREBASE_STORAGE_BUCKET");
  final messagingSenderId = dotenv.get("FIREBASE_MESSAGING_SENDER_ID");

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return FirebaseOptions(
        apiKey: dotenv.get("ANDROID_API_KEY"),
        appId: dotenv.get("ANDROID_APP_ID"),
        messagingSenderId: messagingSenderId,
        projectId: projectId,
        storageBucket: storageBucket,
      );

    case TargetPlatform.iOS:
      return FirebaseOptions(
        apiKey: dotenv.get("IOS_API_KEY"),
        appId: dotenv.get("IOS_APP_ID"),
        messagingSenderId: messagingSenderId,
        projectId: projectId,
        storageBucket: storageBucket,
        iosBundleId: dotenv.get("IOS_BUNDLE_ID"),
      );

    default:
      throw UnsupportedError("Platform no supported .env");
  }
}
