import 'dart:async';
// import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCM {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void requestPermission() {
    // StreamSubscription iosSubscription;

    // if (Platform.isIOS) {
    //   iosSubscription = _firebaseMessaging.onIosSettingsRegistered.listen((data) {
    //     // save the token  OR subscribe to a topic here
    //   });

    _firebaseMessaging
        .requestNotificationPermissions(IosNotificationSettings());
    // }
  }

  Future<String> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  void configure(context) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
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
