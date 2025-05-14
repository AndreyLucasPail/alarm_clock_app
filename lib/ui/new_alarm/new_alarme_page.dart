import 'package:alarm_clock_app/mixins/new_alarm_mixin.dart';
import 'package:flutter/material.dart';

class NewAlarmePage extends StatefulWidget {
  const NewAlarmePage({super.key});

  static const String tag = "newAlarmPage";

  @override
  State<NewAlarmePage> createState() => _NewAlarmePageState();
}

class _NewAlarmePageState extends State<NewAlarmePage> with NewAlarmMixin {
  @override
  void initState() {
    super.initState();
    initMixin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body());
  }

  Widget body() {
    return Column();
  }
}
