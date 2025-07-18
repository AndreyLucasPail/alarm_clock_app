// ignore_for_file: avoid_print

import 'package:alarm_clock_app/model/alarm_clock_model.dart';
import 'package:alarm_clock_app/repository/db_repository.dart';
import 'package:flutter/material.dart';

enum RepeatOption { once, daily, weekDay, custom }

class AlarmClockManager extends ChangeNotifier {
  List<AlarmClockModel> alarmsList = [];
  final DataBaseRepository dataBaseRepository = DataBaseRepository();
  RepeatOption _selectedOption = RepeatOption.once;
  int _hour = 0;
  int _minute = 0;

  RepeatOption get selectedOption => _selectedOption;
  int get hour => _hour;
  int get minute => _minute;

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

  Future<void> addNewAlarm(AlarmClockModel newAlarm) async {
    try {
      await dataBaseRepository.insertNewAlarm(newAlarm);
      await getAlarms();
      notifyListeners();
    } catch (e) {
      print("Não foi possivel adicionar alarme :$e manager");
    }
  }

  Future<void> delete(int alarmId) async {
    try {
      await dataBaseRepository.deleteAlarm(alarmId);
      await getAlarms();
      notifyListeners();
    } catch (e) {
      print("Não foi possivel deletar alarme :$e manager");
    }
  }

  Future<void> update(AlarmClockModel alarm) async {
    try {
      await dataBaseRepository.updateAlarm(alarm);
      await getAlarms();
    } catch (e) {
      print("Não foi possivel editar alarme :$e manager");
    }
  }

  Future<void> deleteDb() async {
    try {
      await dataBaseRepository.deleteDB();
    } catch (e) {
      print("Não foi possivel deletar o banco de dados :$e manager");
    }
  }

  void alarmRepeationOption(RepeatOption option) {
    _selectedOption = option;
    notifyListeners();
  }

  void setHour(int value) {
    _hour = value;
    notifyListeners();
  }

  void setMinute(int value) {
    _minute = value;
    notifyListeners();
  }
}
