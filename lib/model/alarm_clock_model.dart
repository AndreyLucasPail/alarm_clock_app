class AlarmClockModel {
  AlarmClockModel({this.id, this.hour, this.minute, this.title, this.vibrate});

  int? id;
  int? hour;
  int? minute;
  String? title = "";
  bool? vibrate = true;

  factory AlarmClockModel.fromJson(Map<String, dynamic> json) {
    return AlarmClockModel(
      id: json["idColumn"],
      hour: json["hourColumn"],
      minute: json["minuteColumn"],
      title: json["titleColumn"],
      vibrate: json["vibrateColumn"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idColumn": id,
      "hourColumn": hour,
      "minuteColumn": minute,
      "titleColumn": title,
      "vibrateColumn": vibrate,
    };
  }
}
