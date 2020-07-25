import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCM {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<String> getFCMToken() async {
    return await _fcm.getToken();
  }

  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}
