import 'package:alarm_clock_app/manager/alarm_clock_manager.dart';
import 'package:alarm_clock_app/manager/song_player_manager.dart';
import 'package:alarm_clock_app/routes/app_routes.dart';
import 'package:alarm_clock_app/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  await deleteOldDatabase();
  runApp(const MyApp());
}

Future<void> deleteOldDatabase() async {
  WidgetsFlutterBinding.ensureInitialized(); // necessário antes de path/db
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, "alarmClock_db.db");

  await deleteDatabase(path); // Apaga o banco de dados antigo
  print('🗑️ Banco de dados excluído com sucesso.');
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
