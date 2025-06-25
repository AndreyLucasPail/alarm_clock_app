import 'package:alarm_clock_app/manager/alarm_clock_manager.dart';
import 'package:alarm_clock_app/manager/song_player_manager.dart';
import 'package:alarm_clock_app/mixins/new_alarm_mixin.dart';
import 'package:alarm_clock_app/model/alarm_clock_model.dart';
import 'package:alarm_clock_app/utils/customcolors.dart';
import 'package:alarm_clock_app/widgets/song_container.dart';
import 'package:flutter/material.dart';
import 'package:alarm_clock_app/data/alarm_song.dart';
import 'package:provider/provider.dart';

class NewAlarmePage extends StatefulWidget {
  const NewAlarmePage({super.key});

  static const String tag = "newAlarmPage";

  @override
  State<NewAlarmePage> createState() => _NewAlarmePageState();
}

class _NewAlarmePageState extends State<NewAlarmePage>
    with NewAlarmMixin, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initMixin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body(), appBar: appBar());
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 20,
        children: [
          Row(
            children: [
              selectTimeScroll(24, 1, hourController),
              line(),
              selectTimeScroll(60, 0, minuteController),
            ],
          ),
          selectAlarmSong(),
          repeat(),
          Spacer(),
          saveNewAlarmButtons(),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        "Adicionar alarme",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      iconTheme: IconThemeData(size: 30),
      centerTitle: true,
    );
  }

  Widget selectTimeScroll(
    int generate,
    int num,
    FixedExtentScrollController controller,
  ) {
    final timeManager = Provider.of<AlarmClockManager>(context, listen: true);
    final isHour = controller == hourController;

    final List<String> items = isHour ? hour : minute;

    return Flexible(
      child: SizedBox(
        height: 250,
        child: ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: 80,
          onSelectedItemChanged: (value) {
            if (isHour) {
              timeManager.setHour(value);
            } else {
              timeManager.setMinute(value);
            }
          },
          childDelegate: ListWheelChildLoopingListDelegate(
            children:
                items.map((text) {
                  final bool isSelected =
                      text ==
                      (isHour ? timeManager.hour : timeManager.minute)
                          .toString()
                          .padLeft(2, '0');

                  return Text(
                    text,
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

  Widget line() {
    return Container(
      height: 200,
      width: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CustomColors.gray,
            CustomColors.rotPurple,
            CustomColors.rotPurple,
            CustomColors.gray,
          ],
        ),
      ),
    );
  }

  Widget selectAlarmSong() {
    return GestureDetector(
      onTap:
          () => showDialog(
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
                          alarmSongDialog(),
                        ],
                      ),
                    ),
                  ),
                ),
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Toque",
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 30),
        ],
      ),
    );
  }

  Widget alarmSongDialog() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: alarmSong.map((song) => SongContainer(song: song)).toList(),
    );
  }

  Widget repeat() {
    return GestureDetector(
      onTap: () => repeatDialog(),
      child: Row(
        children: [
          Text(
            "Repetir",
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Text(
            "Uma vez",
            style: TextStyle(color: CustomColors.black, fontSize: 16),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 30),
        ],
      ),
    );
  }

  Future repeatDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer<AlarmClockManager>(
          builder: (__, alarmManager, _) {
            return Dialog(
              backgroundColor: CustomColors.supernova,
              insetPadding: EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildRepeatButton(
                        "Uma vez",
                        alarmManager,
                        RepeatOption.once,
                      ),
                      buildRepeatButton(
                        "Diariamente",
                        alarmManager,
                        RepeatOption.daily,
                      ),
                      buildRepeatButton(
                        "Seg. a Sex.",
                        alarmManager,
                        RepeatOption.weekDay,
                      ),
                      buildRepeatButton(
                        "Personalizado",
                        alarmManager,
                        RepeatOption.custom,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildRepeatButton(
    String text,
    AlarmClockManager manager,
    RepeatOption option,
  ) {
    final bool isSelect = manager.selectedOption == option;

    return SizedBox(
      height: 85,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelect ? CustomColors.redOrange : CustomColors.lavender,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        onPressed: () {
          manager.alarmRepeationOption(option);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 20,
          children: [
            isSelect
                ? Icon(
                  Icons.check,
                  color: isSelect ? CustomColors.white : CustomColors.black,
                  size: 24,
                )
                : Container(),
            Text(
              text,
              style: TextStyle(
                color: isSelect ? CustomColors.white : CustomColors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget saveNewAlarmButtons() {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 55,
        width: 150,
        child: ElevatedButton(
          onPressed: () async {
            final manager = Provider.of<AlarmClockManager>(
              context,
              listen: false,
            );

            final selectedSong =
                Provider.of<SongPlayerManager>(
                  context,
                  listen: false,
                ).selecSong;

            AlarmClockModel newAlarm = AlarmClockModel(
              hour: manager.hour,
              minute: manager.minute,
              title: "",
              vibrate: 1,
              activate: 1,
              song: selectedSong?.path ?? "wake_up_at_7am.mp3",
            );
            await manager.addNewAlarm(newAlarm);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.supernova,
          ),
          child: Text(
            "Salvar",
            style: TextStyle(color: CustomColors.black, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
