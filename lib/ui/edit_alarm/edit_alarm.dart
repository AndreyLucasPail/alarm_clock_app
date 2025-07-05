import 'package:flutter/material.dart';

class EditAlarm extends StatefulWidget {
  const EditAlarm({super.key});

  static const tag = "editAlarm";

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
