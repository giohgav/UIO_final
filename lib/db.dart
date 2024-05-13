import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

List<Map<String, dynamic>> resultadosGlobales = [];

Future<void> ejecutarConsulta(String sql) async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'database.db');
  final database = await openDatabase(path);

  // Verifica si la tabla 'sensor' y 'logger' existe

  bool loggerTableExists = await database.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='logger';")
      .then((value) => value.isNotEmpty);

  bool sensorTableExists = await database.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='sensor';")
      .then((value) => value.isNotEmpty);

  bool tablesExist = loggerTableExists && sensorTableExists;

  // Crea las tablas si no existen
  if (!tablesExist) {
    await database.execute('''
      CREATE TABLE logger (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_sensor TEXT,
        fecha DATETIME,
        max REAL,
        min REAL,
        valor REAL
      )
    ''');

    await database.execute('''
      CREATE TABLE sensor (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_sensor TEXT,
        codigo_sensor TEXT,
        max REAL,
        min REAL
      )
    ''');

    // Inserta algunos valores de ejemplo
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO logger (id_sensor, fecha, max, min, valor) VALUES (?, ?, ?, ?, ?)',
          ['0001','2024-04-12 10:00:00', 190.0, 170.0, 183.0]);
      await txn.rawInsert(
          'INSERT INTO sensor (id_sensor, codigo_sensor, max, min) VALUES (?, ?, ?, ?)',
          ['0001', 'u25axd', 0, 0 ]);
    });
  }

  // Ejecuta la consulta proporcionada
  if (sql.toLowerCase().startsWith("select")) {
    resultadosGlobales = await database.rawQuery(sql);
  } else {
    await database.execute(sql);
  }

  await database.close();
}
