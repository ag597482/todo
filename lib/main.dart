import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_10y.dart';

import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeTimeZones();
  AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings iosInitializationSettings =
      const DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestCriticalPermission: true,
          requestSoundPermission: true);
  InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings, iOS: iosInitializationSettings);
  bool? initialized =
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  print("is init");
  print(initialized);

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails("channelId", "channelName",
          priority: Priority.max, importance: Importance.max);

  DarwinNotificationDetails darwinNotificationDetails =
      const DarwinNotificationDetails(
          presentAlert: true, presentBadge: true, presentSound: true);
  MainApp({super.key});

  void showNotification() async {
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0, "title", "body", notificationDetails);
    // DateTime dateTime = DateTime.now().add(Duration(seconds: 5));
    // await flutterLocalNotificationsPlugin.schedule(
    //     0, "title", "after 5 sec", dateTime, notificationDetails);
  }

  void scheduleNotification(int timeInSecond) async {
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    DateTime dateTime = DateTime.now().add(Duration(seconds: timeInSecond));

    tz.TZDateTime tzDateTime = tz.TZDateTime.from(dateTime, tz.local);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Sample Notificaiton",
        "body after $timeInSecond seconds",
        tzDateTime,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController timeController = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showNotification();
              },
              child: const Text('Show Notification'),
            ),
            Container(
              alignment: Alignment.center,
              width: 200,
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: timeController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(),
                  hintText: 'Enter time in sec',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                scheduleNotification(int.parse(timeController.text));
              },
              child: const Text('Schedule Notification'),
            )
          ],
        ),
      )),
    );
  }
}
