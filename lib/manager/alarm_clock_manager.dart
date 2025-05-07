// ignore_for_file: avoid_print

import 'package:alarm_clock_app/model/alarm_clock_model.dart';
import 'package:alarm_clock_app/repository/db_repository.dart';
import 'package:flutter/material.dart';

class AlarmClockManager extends ChangeNotifier {
  List<AlarmClockModel> alarmsList = [];
  final DataBaseRepository dataBaseRepository = DataBaseRepository();

  Future<void> getAlarms() async {
    try {
      final response = await dataBaseRepository.getAlarms();
      alarmsList =
          response.map((alarm) => AlarmClockModel.fromJson(alarm)).toList();
      notifyListeners();
    } catch (e) {
      print("Não foi possivel buscar alarmes :$e manager");
    }
  }
}
