// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;

// final FlutterLocalNotificationsPlugin notificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> initNotifications() async {
//   tz.initializeTimeZones();

//   const AndroidInitializationSettings androidSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   const InitializationSettings settings = InitializationSettings(
//     android: androidSettings,
//   );

//   await notificationsPlugin.initialize(settings);
// }

// Future<void> scheduleAlarm(DateTime dateTime, int id, String label) async {
//   await notificationsPlugin.zonedSchedule(
//     id,
//     'Alarme',
//     label,
//     tz.TZDateTime.from(dateTime, tz.local),
//     const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'alarm_channel',
//         'Alarmes',
//         importance: Importance.max,
//         priority: Priority.high,
//         sound: RawResourceAndroidNotificationSound('alarm_sound'),
//         playSound: true,
//       ),
//     ),
//     androidAllowWhileIdle: true,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//     matchDateTimeComponents: DateTimeComponents.time, // para repetir
//   );
// }
