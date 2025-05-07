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

  Future<void> newAlarm(AlarmClockModel newAlarm) async {
    try {
      await dataBaseRepository.insertNewAlarm(newAlarm);
      notifyListeners();
    } catch (e) {
      print("Não foi possivel adicionar alarme :$e manager");
    }
  }

  Future<void> delete(int alarmId) async {
    try {
      await dataBaseRepository.deleteAlarm(alarmId);
      notifyListeners();
    } catch (e) {
      print("Não foi possivel deletar alarme :$e manager");
    }
  }

  Future<void> update(AlarmClockModel alarm) async {
    try {
      await dataBaseRepository.updateAlarm(alarm);
    } catch (e) {
      print("Não foi possivel editar alarme :$e manager");
    }
  }
}
