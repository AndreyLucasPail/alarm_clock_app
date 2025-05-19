import 'package:alarm_clock_app/manager/alarm_clock_manager.dart';
import 'package:alarm_clock_app/mixins/new_alarm_mixin.dart';
import 'package:alarm_clock_app/ui/utils/customcolors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewAlarmePage extends StatefulWidget {
  const NewAlarmePage({super.key});

  static const String tag = "newAlarmPage";

  @override
  State<NewAlarmePage> createState() => _NewAlarmePageState();
}

class _NewAlarmePageState extends State<NewAlarmePage> with NewAlarmMixin {
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
    final isHour = controller == hourController;

    return Flexible(
      child: SizedBox(
        height: 250,
        child: ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: 80,
          onSelectedItemChanged: (value) {
            setState(() {
              if (isHour) {
                selectHourIndex = value;
              } else {
                selectMinIndex = value;
              }
            });
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              bool isSelect =
                  isHour ? index == selectHourIndex : index == selectMinIndex;

              return Text(
                "${index + num}",
                style: TextStyle(
                  color: isSelect ? CustomColors.redOrange : CustomColors.black,
                  fontSize: 30,
                  fontWeight: isSelect ? FontWeight.bold : FontWeight.normal,
                ),
              );
            },
            childCount: generate,
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
                (context) => StatefulBuilder(
                  builder: (context, state) {
                    return Dialog.fullscreen(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  player.stop();
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close),
                              ),
                              alarmSongDialog(state),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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

  Widget alarmSongDialog(Function state) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        songContainer(CustomColors.redOrange, "alarmtypebeatf.mp3", state),
        songContainer(CustomColors.rotPurple, "plantasia_alarm.mp3", state),
        songContainer(CustomColors.supernova, "wake_up_at_7am.mp3", state),
        songContainer(CustomColors.black, "wake_up_now.mp3", state),
      ],
    );
  }

  Widget songContainer(Color color, String path, Function state) {
    return InkWell(
      onTap: () async {
        if (currentPlaying == path) {
          await player.stop();
          state(() {
            currentPlaying = null;
          });
        } else {
          await player.stop();
          await Future.delayed(Duration(milliseconds: 100));
          await player.play(AssetSource(path), volume: 100);
          state(() {
            currentPlaying = path;
          });
        }
      },
      child: Container(
        height: 250,
        width: 180,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
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
          builder: (_, maneger, __) {
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
                      buildRepeatButton("Uma vez", maneger, RepeatOption.once),
                      buildRepeatButton(
                        "Diariamente",
                        maneger,
                        RepeatOption.daily,
                      ),
                      buildRepeatButton(
                        "Seg. a Sex.",
                        maneger,
                        RepeatOption.weekDay,
                      ),
                      buildRepeatButton(
                        "Personalizado",
                        maneger,
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
}
