import 'package:alarm_clock_app/data/alarm_song.dart';
import 'package:alarm_clock_app/manager/alarm_clock_manager.dart';
import 'package:alarm_clock_app/manager/song_player_manager.dart';
import 'package:alarm_clock_app/mixins/edit_alarm_mixin.dart';
import 'package:alarm_clock_app/model/alarm_clock_model.dart';
import 'package:alarm_clock_app/utils/customcolors.dart';
import 'package:alarm_clock_app/widgets/song_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAlarmArgs {
  EditAlarmArgs(this.alarm);
  AlarmClockModel alarm;
}

class EditAlarmPage extends StatefulWidget {
  const EditAlarmPage({super.key, this.alarm});

  static const tag = "editAlarm";
  final AlarmClockModel? alarm;

  @override
  State<EditAlarmPage> createState() => _EditAlarmState();
}

class _EditAlarmState extends State<EditAlarmPage> with EditAlarmMixin {
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
          spacing: 20,
          children: [
            customAppBar(),
            Row(
              children: [
                selectTimeWheel(hourController),
                selectTimeWheel(minuteController),
              ],
            ),
            selectSong(),
            selectVibrate(),
            deleteAlarm(),
            alarmName(),
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

  Widget selectSong() {
    return InkWell(
      onTap: () => songDialog(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Toque",
            style: TextStyle(fontSize: 20.0, color: CustomColors.black),
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }

  Future songDialog() {
    return showDialog(
      context: context,
      builder:
          (context) => Dialog.fullscreen(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Provider.of<SongPlayerManager>(
                          context,
                          listen: false,
                        ).stop();
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          alarmSong
                              .map((song) => SongContainer(song: song))
                              .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget selectVibrate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Vibrar quando o alarme disparar",
          style: TextStyle(color: CustomColors.black, fontSize: 20.0),
        ),
        Switch(
          value: widget.alarm!.activate == 1,
          onChanged: (bool value) {
            widget.alarm!.activate = value ? 1 : 0;
            Provider.of<AlarmClockManager>(
              context,
              listen: true,
            ).update(widget.alarm!);
          },
        ),
      ],
    );
  }

  Widget deleteAlarm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Excluir após o alarme disparar",
          style: TextStyle(color: CustomColors.black, fontSize: 20.0),
        ),
        Switch(
          value: widget.alarm!.deleteAlarm == 1,
          onChanged: (bool value) {
            widget.alarm!.deleteAlarm = value ? 1 : 0;
            Provider.of<AlarmClockManager>(
              context,
              listen: true,
            ).update(widget.alarm!);
          },
        ),
      ],
    );
  }

  Widget alarmName() {
    return InkWell(
      onTap: () => textFieldBottomSheet(),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: CustomColors.supernova,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Nome",
              style: TextStyle(color: CustomColors.black, fontSize: 20.0),
            ),
            Text(
              "Inserir rótulo",
              style: TextStyle(color: CustomColors.black, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  Future textFieldBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 230,
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(24.0),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              spacing: 20,
              children: [
                Text(
                  "Adicionar rótulo do alarme",
                  style: TextStyle(
                    color: CustomColors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                Row(
                  spacing: 16.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.redOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(16.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: CustomColors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.supernova,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(16.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text("Definir"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
