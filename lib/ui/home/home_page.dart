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
      backgroundColor: CustomColors.lavender,
      // appBar: appBar(),
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

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: alarmRow(list),
            );
          },
          separatorBuilder: (_, __) => SizedBox(height: 16),
          itemCount: manager.alarmsList.length,
        );
      },
    );
  }

  // PreferredSizeWidget appBar() {
  //   return AppBar(
  //     backgroundColor: CustomColors.lavender,
  //     title: Align(
  //       alignment: Alignment.centerRight,
  //       child: Text(
  //         "Alarm",
  //         style: TextStyle(
  //           color: CustomColors.black,
  //           fontSize: 24.0,
  //           fontWeight: FontWeight.bold,
  //           letterSpacing: 1,
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
          value: list.activate == 1,
          valueChanged: (bool value) {
            list.activate = value ? 1 : 0;
            Provider.of<AlarmClockManager>(context, listen: false).update(list);
          },
        ),
      ],
    );
  }

  Widget alarmCard(AlarmClockModel time) {
    return GestureDetector(
      onTap: () => editAlarmDialog(time),
      child: Container(
        height: 260,
        width: 230,
        decoration: BoxDecoration(
          color: CustomColors.supernova,
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(color: CustomColors.white, width: 4),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: Text(
                "AM",
                style: TextStyle(
                  fontSize: 130,
                  color: Colors.white30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    time.hour.toString().padLeft(2, "0"),
                    style: TextStyle(
                      fontSize: 50,
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ":",
                    style: TextStyle(
                      fontSize: 50,
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    time.minute.toString().padLeft(2, "0"),
                    style: TextStyle(
                      fontSize: 50,
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future editAlarmDialog(AlarmClockModel time) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, state) {
            return Dialog(
              child: Container(
                padding: EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          time.hour.toString().padLeft(2, "0"),
                          style: TextStyle(
                            fontSize: 24,
                            color: CustomColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ":",
                          style: TextStyle(
                            fontSize: 24,
                            color: CustomColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          time.minute.toString().padLeft(2, "0"),
                          style: TextStyle(
                            fontSize: 24,
                            color: CustomColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Switch(
                          value: time.activate == 1,
                          onChanged: (bool value) {
                            state(() {
                              time.activate = value ? 1 : 0;
                            });
                            Provider.of<AlarmClockManager>(
                              context,
                              listen: false,
                            ).update(time);
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        selectTimeWheel(hourController),
                        line(),
                        selectTimeWheel(minuteController),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [additionalSettingsButton(), saveButton()],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget selectTimeWheel(FixedExtentScrollController controller) {
    final timeManager = Provider.of<AlarmClockManager>(context, listen: true);
    final isHour = controller == hourController;

    final List<String> items = isHour ? hour : minute;

    return Flexible(
      child: SizedBox(
        height: 150,
        child: ListWheelScrollView.useDelegate(
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
      height: 150,
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

  Widget additionalSettingsButton() {
    return SizedBox(
      child: ElevatedButton(onPressed: () {}, child: Text("Concluido")),
    );
  }

  Widget saveButton() {
    return SizedBox(
      child: ElevatedButton(onPressed: () {}, child: Text("Concluido")),
    );
  }
}
