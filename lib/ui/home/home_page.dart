import 'package:alarm_clock_app/mixins/home_mixin.dart';
import 'package:alarm_clock_app/ui/utils/customcolors.dart';
import 'package:alarm_clock_app/widgets/custom_switch.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: appBar(),
      body: body(),
      floatingActionButton: floatingButton(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [alarmRow()]),
      ),
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

  Widget floatingButton() {
    return SizedBox(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        onPressed: () => selectAlarmTimeDialog(),
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

  Future selectAlarmTimeDialog() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 6,
            children: [
              Flexible(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    selectTimeScroll(24, 1, hourController),
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
                    selectTimeScroll(60, 0, minuteController),
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
      childDelegate: ListWheelChildLoopingListDelegate(
        children: List.generate(
          generate,
          (index) => Text(
            "${index + num}",
            style: TextStyle(color: CustomColors.supernova),
          ),
        ),
      ),
    );
  }
}
