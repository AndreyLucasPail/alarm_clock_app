import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

mixin HomeMixin {
  bool activateB = false;

  final player = AudioPlayer();

  late int initialHour;
  late int initialMinute;

  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  final List<String> hour = List.generate(
    24,
    (i) => (i + 1).toString().padLeft(2, "0"),
  );
  final List<String> minute = List.generate(
    60,
    (i) => i.toString().padLeft(2, "0"),
  );

  void initMixin() {
    initialHour = DateTime.now().hour;
    initialMinute = DateTime.now().minute;

    hourController = FixedExtentScrollController();
    minuteController = FixedExtentScrollController();
  }
}
