class AlarmClockModel {
  AlarmClockModel({
    this.id,
    required this.hour,
    required this.minute,
    required this.title,
    required this.vibrate,
    required this.activate,
    required this.song,
    required this.deleteAlarm,
  });

  int? id;
  int? hour;
  int? minute;
  String? title;
  int? vibrate = 1;
  int? activate = 0;
  String? song;
  int? deleteAlarm = 0;

  factory AlarmClockModel.fromJson(Map<String, dynamic> json) {
    return AlarmClockModel(
      id: json["idColumn"],
      hour: json["hourColumn"],
      minute: json["minuteColumn"],
      title: json["titleColumn"] ?? "",
      vibrate: json["vibrateColumn"] ?? 1,
      activate: json["activateColumn"] ?? 0,
      song: json["songColumn"] ?? "assets/wake_up_at_7am.mp3",
      deleteAlarm: json["deleteColumn"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idColumn": id,
      "hourColumn": hour,
      "minuteColumn": minute,
      "titleColumn": title ?? "",
      "vibrateColumn": vibrate ?? 1,
      "activateColumn": activate ?? 0,
      "songColumn": song ?? "assets/wake_up_at_7am.mp3",
      "deleteColumn": deleteAlarm ?? 0,
    };
  }
}
