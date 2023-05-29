import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_10y.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:todo/screens/tab_layout.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeTimeZones();
  AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings iosInitializationSettings =
      DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestCriticalPermission: true,
          requestSoundPermission: true);
  InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings, iOS: iosInitializationSettings);
  bool? initialized =
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  print(initialized);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  void showNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channelId", "channelName",
            priority: Priority.max, importance: Importance.max);

    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0, "title", "body", notificationDetails);
    DateTime dateTime = DateTime.now().add(Duration(seconds: 5));
    await flutterLocalNotificationsPlugin.schedule(
        0, "title", "after 5 sec", dateTime, notificationDetails);

    tz.TZDateTime tzDateTime = tz.TZDateTime.from(dateTime, tz.local);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0, "title", "body after 5", tzDateTime, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TabLayout()
        // Scaffold(
        //   body: Center(
        //     child: ElevatedButton(onPressed: (){
        //       showNotification();
        //     }, child: const Text('Hello World!'),)
        //   ),
        // ),
        );
  }
}
