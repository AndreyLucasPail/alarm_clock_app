import 'package:alarm_clock_app/utils/customcolors.dart';
import 'package:flutter/widgets.dart';

class AlarmSong {
  final String name;
  final String path;
  final Color color;
  AlarmSong({required this.name, required this.path, required this.color});
}

final List<AlarmSong> alarmSong = [
  AlarmSong(
    name: "Type Beat",
    path: "alarmtypebeatf.mp3",
    color: CustomColors.redOrange,
  ),
  AlarmSong(
    name: "Plantasia",
    path: "plantasia_alarm.mp3",
    color: CustomColors.rotPurple,
  ),
  AlarmSong(
    name: "Wake 7AM",
    path: "wake_up_at_7am.mp3",
    color: CustomColors.supernova,
  ),
  AlarmSong(
    name: "Wake Now",
    path: "wake_up_now.mp3",
    color: CustomColors.black,
  ),
];
