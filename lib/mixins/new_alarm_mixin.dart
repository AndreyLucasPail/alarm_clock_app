import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

mixin NewAlarmMixin {
  final Map<String, AnimationController> controllers = {};

  final List<String> audioPaths = [
    "alarmtypebeatf.mp3",
    "plantasia_alarm.mp3",
    "wake_up_at_7am.mp3",
    "wake_up_now.mp3",
  ];

  late int initialHour;
  late int initialMinute;

  int selectHourIndex = 0;
  int selectMinIndex = 0;

  String? currentPlaying;

  final player = AudioPlayer();

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
