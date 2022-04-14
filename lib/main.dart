import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx/Notification/notification_controller.dart';
import 'package:getx/Pages/home_page.dart';
import 'package:getx/Theme/custom_theme.dart';
import 'package:getx/Theme/theme_color.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  // AwesomeNotifications().initialize(null, [
  //   NotificationChannel(
  //       channelKey: "Test key",
  //       channelName: "Test Channel",
  //       channelDescription: "Test Notifacation")
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Home_Page(),
      debugShowCheckedModeBanner: false,
      themeMode: Custom_Theme().theme,
      theme: themes.light,
      darkTheme: themes.dark,
    );
  }
}