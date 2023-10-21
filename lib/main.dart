import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dressupexchange_mobile/routes/routes.dart';
import 'package:dressupexchange_mobile/themes/theme.dart';
import 'package:dressupexchange_mobile/firebase_options.dart';
import 'package:dressupexchange_mobile/utils/notification_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  configureFirebaseMessagingAndLocalNotifications(
      flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: customLightTheme,
      initialRoute: "/introduction",
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
