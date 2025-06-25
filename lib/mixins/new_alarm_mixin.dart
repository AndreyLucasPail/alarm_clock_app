import 'package:flutter/material.dart';

mixin NewAlarmMixin {
  late int initialHour;
  late int initialMinute;

  int selectHourIndex = 0;
  int selectMinIndex = 0;

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

    hourController = FixedExtentScrollController(initialItem: initialHour);
    minuteController = FixedExtentScrollController(initialItem: initialMinute);
  }
}
