import 'package:flutter/material.dart';
import 'package:dressupexchange_mobile/routes/routes.dart';
import 'package:dressupexchange_mobile/themes/theme.dart';
import 'package:dressupexchange_mobile/pages/introduction_screen.dart';

void main() {
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
