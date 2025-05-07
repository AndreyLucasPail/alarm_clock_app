import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String alarmClockTable = "alarmClockTable";
String id = "idColumn";
String hourColumn = "hourColumn";
String minuteColumn = "minuteColumn";
String titleColumn = "titleColumn";
String repeatColumn = "repeatColumn";
String vibrateColumn = "vibrateColumn";

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
          ' $minuteColumn INTEGER, $titleColumn STRING, $repeatColumn INTEGER, $vibrateColumn BOOL)',
        );
      },
    );

    return alarmClockDb;
  }
}
