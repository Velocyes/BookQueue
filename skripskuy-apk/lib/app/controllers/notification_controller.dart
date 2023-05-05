import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  FirebaseMessaging fm = FirebaseMessaging.instance;

  NotificationSettings settings;

  StreamController updateUINotifier = StreamController.broadcast();

  @override
  void onInit() async {
    super.onInit();
    settings = await fm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        Get.snackbar(
            message.notification.title != null
                ? message.notification.title
                : "",
            message.notification.body != null ? message.notification.body : "",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      }
      updateUINotifier.add(true);
    });
  }
}
