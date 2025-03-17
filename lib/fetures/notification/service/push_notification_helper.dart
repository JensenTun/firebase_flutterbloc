import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.toString());
  print(message.notification?.title ?? "");
}

class PushNotificationHelper {
  static String fcmtoken = "";
  static Future<void> initialized() async {
    await Firebase.initializeApp();
    await FirebaseAnalytics.instance.logAppOpen();
    if (Platform.isAndroid) {
      // Local Notification
      FirebaseMessaging.instance.requestPermission(
        sound: true,
        badge: true,
        alert: true,
      );
    } else if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission(
        sound: true,
        badge: true,
        alert: true,
      );
    }
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    await getDeviceTokenToSendNotification();

    // If app is terminated state & use click notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        print("New Notification");
      }
    });

    // App is forground this method is work
    FirebaseMessaging.onMessage.listen((message) {
      print('FirebaseMessaging.onMessage.listen');
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data);

        // Local Notification Code to Display Alert
        NotificationHelper.displayNotification(message);
      }
    });

    // App on Background not Terminated
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('FirebaseMessaging.onMessageOpenedApp.listen');
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data);

        // Local Notification Code to Display Alert
      }
    });
  }

  //
  static Future<void> getDeviceTokenToSendNotification() async {
    fcmtoken = (await FirebaseMessaging.instance.getToken()).toString();
    print('Token');
    print(fcmtoken);
    print('Token');
  }
}

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void initialized() {
    const AndroidInitializationSettings initialzationSettingAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(android: initialzationSettingAndroid),
      onDidReceiveNotificationResponse: (detail) {},
      onDidReceiveBackgroundNotificationResponse: localBackgroundHandler,
    );
  }

  static void displayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().microsecondsSinceEpoch ~/ 1000;
      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "push notifcation channel",
          "push_notifcation_channel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );
      await flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["_id"] ?? "",
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}

Future<void> localBackgroundHandler(NotificationResponse data) async {
  print(data.toString());
}
