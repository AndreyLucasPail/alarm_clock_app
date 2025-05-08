import 'package:alarm_clock_app/ui/utils/customcolors.dart';
import 'package:alarm_clock_app/widgets/custom_switch.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool activateB = false;

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

  // Widget switchButton() {
  //   return Flexible(
  //     child: SizedBox(
  //       height: 170,
  //       width: 170,
  //       child: Transform.rotate(
  //         angle: -3.12 / 2,
  //         child: FittedBox(
  //           fit: BoxFit.fill,
  //           child: Switch.adaptive(
  //             value: activateB,
  //             onChanged: (value) {
  //               setState(() {
  //                 activateB = value;
  //               });
  //             },
  //             activeColor: CustomColors.supernova,
  //             activeTrackColor: CustomColors.white,
  //             inactiveThumbColor: CustomColors.rotPurple,
  //             inactiveTrackColor: CustomColors.white,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Future selectAlarmTimeDialog() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(height: MediaQuery.of(context).size.height * 0.6);
      },
    );
  }
}
