class AlarmClockModel {
  AlarmClockModel({
    this.id,
    required this.hour,
    required this.minute,
    required this.title,
    required this.vibrate,
    required this.activate,
    required this.song,
  });

  int? id;
  int? hour;
  int? minute;
  String? title;
  bool? vibrate = true;
  bool? activate = false;
  String? song;

  factory AlarmClockModel.fromJson(Map<String, dynamic> json) {
    return AlarmClockModel(
      id: json["idColumn"],
      hour: json["hourColumn"],
      minute: json["minuteColumn"],
      title: json["titleColumn"] ?? "",
      vibrate: json["vibrateColumn"] ?? true,
      activate: json["activateColumn"] ?? false,
      song: json["songColumn"] ?? "assets/wake_up_at_7am.mp3",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idColumn": id,
      "hourColumn": hour,
      "minuteColumn": minute,
      "titleColumn": title ?? "",
      "vibrateColumn": vibrate ?? true,
      "activateColumn": activate ?? false,
      "songColumn": song ?? "assets/wake_up_at_7am.mp3",
    };
  }
}
