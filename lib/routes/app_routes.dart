import 'package:alarm_clock_app/ui/edit_alarm/edit_alarm.dart';
import 'package:alarm_clock_app/ui/home/home_page.dart';
import 'package:alarm_clock_app/ui/new_alarm/new_alarme_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route generateRoutes(RouteSettings settings) {
    Widget screen = getScreenNullable(settings) ?? const HomePage();

    return MaterialPageRoute(builder: (context) => screen, settings: settings);
  }

  static Widget? getScreenNullable(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.tag:
        return const HomePage();
      case NewAlarmePage.tag:
        return const NewAlarmePage();
      case EditAlarm.tag:
        final args = settings.arguments as EditAlarmArgs;
        return EditAlarm(alarm: args.alarm);
      default:
        return null;
    }
  }
}
