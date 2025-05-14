import 'package:alarm_clock_app/manager/alarm_clock_manager.dart';
import 'package:alarm_clock_app/mixins/home_mixin.dart';
import 'package:alarm_clock_app/ui/new_alarm/new_alarme_page.dart';
import 'package:alarm_clock_app/ui/utils/customcolors.dart';
import 'package:alarm_clock_app/widgets/custom_switch.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String tag = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeMixin {
  @override
  void initState() {
    super.initState();
    initMixin();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: CustomColors.white,
      appBar: appBar(),
      body: body(),
      floatingActionButton: floatingButton(scaffoldKey),
    );
  }

  Widget body() {
    return Consumer<AlarmClockManager>(
      builder: (_, manager, __) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                alarmRow(),
                SizedBox(height: 50),
                Row(
                  children: [
                    IconButton(
                      onPressed:
                          () => player.play(AssetSource("wake_up_at_7am.mp3")),
                      icon: Icon(Icons.play_arrow),
                      iconSize: 100,
                    ),
                    IconButton(
                      onPressed: () => player.stop(),
                      icon: Icon(Icons.stop),
                      iconSize: 100,
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

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: CustomColors.white,
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "Alarm",
          style: TextStyle(
            color: CustomColors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget floatingButton(GlobalKey<ScaffoldState> scaffoldKey) {
    return SizedBox(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewAlarmePage.tag),
        backgroundColor: CustomColors.redOrange,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: CustomColors.white, size: 40),
      ),
    );
  }

  Widget alarmRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        alarmCard(),
        CustomSwitch(
          value: activateB,
          valueChanged: (bool value) {
            setState(() {
              activateB = value;
            });
          },
        ),
      ],
    );
  }

  Widget alarmCard() {
    return Container(
      height: 260,
      width: 230,
      decoration: BoxDecoration(
        color: CustomColors.supernova,
        borderRadius: BorderRadius.circular(40.0),
      ),
    );
  }

  Future addNewAlarmTime() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  spacing: 6,
                  children: [
                    Flexible(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            child: selectTimeScroll(24, 1, hourController),
                          ),
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            child: selectTimeScroll(60, 0, minuteController),
                          ),
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                selectAlarmSong(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget selectTimeScroll(
    int generate,
    int num,
    FixedExtentScrollController controller,
  ) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: 80,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) {
          return Text(
            "${index + num}",
            style: TextStyle(color: CustomColors.black, fontSize: 24),
          );
        },
        childCount: generate,
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
