import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../app_manager.dart';
import '../navigator/route_service.dart';

part 'local_notification_service.dart';

StreamController firebaseController = StreamController();
BuildContext? context = AppManager.globalKeyRootMaterial.currentContext;

class FirebaseMessagingService {
  FirebaseMessagingService();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void onMessage() async {
    LocalNotificationService.LocalNotificationServices()
        .initFlutterLocalNotificationPlugin(flutterLocalNotificationsPlugin);
    FirebaseMessaging.instance
        .getToken()
        .then((value) => print("TOKEN FIREBASE DEV: ${value}"));
    FirebaseMessaging.onMessage.listen((message) {
      print('notification on message ${message.notification?.toMap()}');
      _checkReCallWhenChange(message.data);
      // context?.read<NotificationsCubit>().getUnseenNotification();
      _handleMessage(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print('message opened app');
      LocalNotificationService.LocalNotificationServices()
          .handleRouteNotification(json.encode(message.data));
    });

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // settings.lockScreen;
  }

  _handleMessage(RemoteMessage message) async {
    print('Have notification on message data: ${message.data}');
    RemoteNotification? notification = message.notification;
    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null) {
      LocalNotificationService.LocalNotificationServices()
          .showNotification(flutterLocalNotificationsPlugin, message);
    }
  }

  _checkReCallWhenChange(Map<String, dynamic> data) {
    print('notificationData.event ${data}');
  }
}
