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

  AnimationController? controller1;
  AnimationController? controller2;
  AnimationController? controller3;
  AnimationController? controller4;

  void initMixin() {
    initialHour = DateTime.now().hour;
    initialMinute = DateTime.now().minute;

    hourController = FixedExtentScrollController(initialItem: initialHour);
    minuteController = FixedExtentScrollController(initialItem: initialMinute);
  }
}
