import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dressupexchange_mobile/utils/notification_database.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future<void> _saveNotificationToStorage(RemoteMessage message) async {
  try {
    final notificationData = {
      'title': message.notification?.title ?? '',
      'body': message.notification?.body ?? '',
    };
    await NotificationDatabase.instance.insertNotification(notificationData);
  } catch (e) {
    print("Error saving notification to storage: $e");
  }
}

void configureFirebaseMessagingAndLocalNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      _saveNotificationToStorage(message);
      flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'due_channel',
            'DUE Promotion',
            channelDescription:
                "Receive notifications about exciting cosplay clothing promotions",
            importance: Importance.max,
          ),
        ),
      );
    }
  });
}
