import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dressupexchange_mobile/routes/routes.dart';
import 'package:dressupexchange_mobile/themes/theme.dart';
import 'package:dressupexchange_mobile/utils/notification_database.dart';
import 'package:dressupexchange_mobile/firebase_options.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialize flutter_local_notifications
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// Configure the initialization settings
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  // Initialize the plugin with the initialization settings
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('Got a message whilst in the foreground!');
    // print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      // Save the notification to the SQLite database
      _saveNotificationToStorage(message);
      // Show the notification using flutter_local_notifications
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
  String? token = await messaging.getToken();
  print("FCM TOKEN");
  print(token);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: customLightTheme,
      //darkTheme: customDarkTheme,
      initialRoute: "/introduction",
      onGenerateRoute: generateRoute, // Use the custom route generator
      debugShowCheckedModeBanner: false,
    );
  }
}
