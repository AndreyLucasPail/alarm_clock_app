import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

mixin HomeMixin {
  bool activateB = false;

  final player = AudioPlayer();

  bool isPlaying = false;

  late int initialHour;
  late int initialMinute;

  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  void initMixin() {
    initialHour = DateTime.now().hour;
    initialMinute = DateTime.now().minute;

    hourController = FixedExtentScrollController(initialItem: initialHour);
    minuteController = FixedExtentScrollController(initialItem: initialMinute);
  }
}
