import 'package:alarm_clock_app/manager/alarm_clock_manager.dart';
import 'package:alarm_clock_app/mixins/edit_alarm_mixin.dart';
import 'package:alarm_clock_app/model/alarm_clock_model.dart';
import 'package:alarm_clock_app/utils/customcolors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAlarmArgs {
  EditAlarmArgs(this.alarm);
  AlarmClockModel alarm;
}

class EditAlarm extends StatefulWidget {
  const EditAlarm({super.key, this.alarm});

  static const tag = "editAlarm";
  final AlarmClockModel? alarm;

  @override
  State<EditAlarm> createState() => _EditAlarmState();
}

class _EditAlarmState extends State<EditAlarm> with EditAlarmMixin {
  @override
  void initState() {
    super.initState();
    initMixin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body());
  }

  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
        child: Column(
          children: [
            customAppBar(),
            Row(
              children: [
                selectTimeWheel(hourController),
                selectTimeWheel(minuteController),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget customAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          iconSize: 34,
          icon: Icon(Icons.close, color: CustomColors.black),
        ),
        Column(
          children: [
            Text(
              "Editar Alarme",
              style: TextStyle(
                fontSize: 20,
                color: CustomColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.alarm!.activate == 1 ? "Ativado" : "Desativado",
              style: TextStyle(fontSize: 16, color: CustomColors.black),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          iconSize: 34,
          icon: Icon(Icons.check, color: CustomColors.black),
        ),
      ],
    );
  }

  Widget selectTimeWheel(FixedExtentScrollController controller) {
    final timeManager = Provider.of<AlarmClockManager>(context, listen: true);
    final isHour = controller == hourController;
    final List<String> items = isHour ? hour : minute;
    return Flexible(
      child: SizedBox(
        height: 300,
        child: ListWheelScrollView.useDelegate(
          itemExtent: 60,
          onSelectedItemChanged: (value) {
            if (isHour) {
              timeManager.setHour(value);
            } else {
              timeManager.setMinute(value);
            }
          },
          childDelegate: ListWheelChildLoopingListDelegate(
            children:
                items.map((time) {
                  final isSelected =
                      time ==
                      (isHour ? timeManager.hour : timeManager.minute)
                          .toString()
                          .padLeft(2, "0");
                  return Text(
                    time,
                    style: TextStyle(
                      color:
                          isSelected
                              ? CustomColors.redOrange
                              : CustomColors.black,
                      fontSize: 30,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
