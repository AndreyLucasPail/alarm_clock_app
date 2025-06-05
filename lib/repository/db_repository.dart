import 'package:alarm_clock_app/model/alarm_clock_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String alarmClockTable = "alarmClockTable";
String id = "idColumn";
String hourColumn = "hourColumn";
String minuteColumn = "minuteColumn";
String titleColumn = "titleColumn";
String repeatColumn = "repeatColumn";
String vibrateColumn = "vibrateColumn";
String activateColumn = "activateColumn";
String songColumn = "songColumn";

class DataBaseRepository {
  DataBaseRepository.internal();

  factory DataBaseRepository() => instance;

  static final DataBaseRepository instance = DataBaseRepository.internal();
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, "alarmClock_db.db");

    Database alarmClockDb = await openDatabase(
      path,
      version: 1,
      onCreate: (db, newerVersion) async {
        db.execute(
          'CREATE TABLE $alarmClockTable ($id INTEGER PRIMARY KEY AUTOINCREMENT, $hourColumn INTEGER,'
          ' $minuteColumn INTEGER, $titleColumn STRING, $repeatColumn INTEGER, $vibrateColumn INTEGER,'
          ' $activateColumn INTEGER, $songColumn STRING)',
        );
      },
    );

    return alarmClockDb;
  }

  Future<List<Map<String, dynamic>>> getAlarms() async {
    Database? alarmsDb = await db;

    final List<Map<String, dynamic>> result = await alarmsDb!.query(
      alarmClockTable,
    );

    return result;
  }

  Future<void> insertNewAlarm(AlarmClockModel alarmClockModel) async {
    Database? alarmDb = await db;

    Map<String, dynamic> addNewAlarm = alarmClockModel.toJson();

    await alarmDb!.insert(alarmClockTable, addNewAlarm);
  }

  Future<void> deleteAlarm(int alarmId) async {
    Database? alarmDb = await db;

    alarmDb!.delete(alarmClockTable, where: "$id = ?", whereArgs: [alarmId]);
  }

  Future<void> updateAlarm(AlarmClockModel alarm) async {
    Database? alarmDb = await db;

    alarmDb!.update(
      alarmClockTable,
      alarm.toJson(),
      where: "$id = ?",
      whereArgs: [alarm.id],
    );
  }

  Future deleteDB() async {
    Database? alarmDb = await db;
    alarmDb!.delete(alarmClockTable);
  }
}
