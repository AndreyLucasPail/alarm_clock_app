import 'package:flutter/material.dart';

mixin NewAlarmMixin {
  late int initialHour;
  late int initialMinute;

  int selectHourIndex = 0;
  int selectMinIndex = 0;

  bool selectOneTime = true;
  bool selectDaily = false;
  bool selectMondeyFriday = false;
  bool selectCustom = false;

  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  void initMixin() {
    initialHour = DateTime.now().hour;
    initialMinute = DateTime.now().minute;

    hourController = FixedExtentScrollController(initialItem: initialHour);
    minuteController = FixedExtentScrollController(initialItem: initialMinute);
  }
}
