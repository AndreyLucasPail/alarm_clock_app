import 'package:alarm_clock_app/manager/alarm_clock_manager.dart';
import 'package:alarm_clock_app/manager/song_player_manager.dart';
import 'package:alarm_clock_app/routes/app_routes.dart';
import 'package:alarm_clock_app/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlarmClockManager()),
        ChangeNotifierProvider(create: (_) => SongPlayerManager()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.tag,
        onGenerateRoute: AppRoutes.generateRoutes,
      ),
    );
  }
}
