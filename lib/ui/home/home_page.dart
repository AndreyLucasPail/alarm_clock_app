import 'package:alarm_clock_app/ui/utils/customcolors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      height: 80,
      width: 80,
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
        Transform.rotate(
          angle: -3.12 / 2,
          child: Switch(value: false, onChanged: (value) {}),
        ),
      ],
    );
  }

  Widget alarmCard() {
    return Container(
      height: 260,
      width: 250,
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
        return Container(height: MediaQuery.of(context).size.height * 0.6);
      },
    );
  }
}
