import 'package:alarm_clock_app/model/alarm_clock_model.dart';
import 'package:flutter/material.dart';

class EditAlarmArgs {
  EditAlarmArgs(this.alarm);
  AlarmClockModel alarm;
}

class EditAlarm extends StatefulWidget {
  const EditAlarm({super.key, this.alarm});

  static const tag = "editAlarm";
  final AlarmClockModel? alarm;

  @override
  State<EditAlarm> createState() => _EditAlarmState();
}

class _EditAlarmState extends State<EditAlarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body(), appBar: AppBar());
  }

  Widget body() {
    return SingleChildScrollView(child: Column());
  }
}
