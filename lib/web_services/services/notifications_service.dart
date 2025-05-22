import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';


class AppNotification {

  Future<void> init() async {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
    });
  }




}
