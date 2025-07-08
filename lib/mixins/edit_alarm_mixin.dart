import 'package:flutter/material.dart';

mixin EditAlarmMixin {
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  final List<String> hour = List.generate(
    24,
    (i) => (i + 1).toString().padLeft(2, "0"),
  );
  final List<String> minute = List.generate(
    24,
    (i) => i.toString().padLeft(2, "0"),
  );

  void initMixin() {
    hourController = FixedExtentScrollController();
    minuteController = FixedExtentScrollController();
  }
}
