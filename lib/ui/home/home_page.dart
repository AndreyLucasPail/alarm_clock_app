import 'package:alarm_clock_app/manager/alarm_clock_manager.dart';
import 'package:alarm_clock_app/mixins/home_mixin.dart';
import 'package:alarm_clock_app/model/alarm_clock_model.dart';
import 'package:alarm_clock_app/ui/new_alarm/new_alarme_page.dart';
import 'package:alarm_clock_app/utils/customcolors.dart';
import 'package:alarm_clock_app/widgets/custom_switch.dart';
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
    final managerP = Provider.of<AlarmClockManager>(context, listen: false);
    managerP.getAlarms();
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
        if (manager.alarmsList.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Nenhum alarme encontrado.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }
        return ListView.separated(
          itemBuilder: (__, index) {
            AlarmClockModel list = manager.alarmsList[index];

            return alarmRow(list);
          },
          separatorBuilder: (_, __) => SizedBox(height: 16),
          itemCount: manager.alarmsList.length,
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

  Widget alarmRow(AlarmClockModel list) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        alarmCard(list),
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

  Widget alarmCard(AlarmClockModel list) {
    return Container(
      height: 260,
      width: 230,
      decoration: BoxDecoration(
        color: CustomColors.supernova,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(children: [Text("${list.hour}"), Text("${list.minute}")]),
    );
  }
}
