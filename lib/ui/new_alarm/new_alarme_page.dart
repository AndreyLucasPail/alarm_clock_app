import 'package:alarm_clock_app/mixins/new_alarm_mixin.dart';
import 'package:alarm_clock_app/ui/utils/customcolors.dart';
import 'package:flutter/material.dart';

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
              selectTimeScroll(24, 1, minuteController),
              Container(height: 200, width: 1, color: CustomColors.black),
              selectTimeScroll(60, 0, minuteController),
            ],
          ),
          selectAlarmSong(),
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
    return Flexible(
      child: SizedBox(
        height: 250,
        child: ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: 80,
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              return Text(
                "${index + num}",
                style: TextStyle(color: CustomColors.black, fontSize: 30),
              );
            },
            childCount: generate,
          ),
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
                  child: Center(
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
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
          Icon(Icons.arrow_forward_ios_rounded, size: 40),
        ],
      ),
    );
  }
}
