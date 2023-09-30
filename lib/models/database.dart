import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'carga.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();
  DatabaseHelper._();

  // Nombre de la base de datos
  final String dbName = 'energia.db';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), dbName);

    // Abre la base de datos (crea una si no existe)
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS cargas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      elemento TEXT,
      cantidad INTEGER,
      potencia INTEGER,
      horasAlDia REAL,
      energiaDia REAL
    )
  ''');
  }

  Future<List<Map<String, dynamic>>> getCargas() async {
    final db = await database;
    return await db.query('cargas');
  }

  Future<int> insertCargas(CargaElectrica cargasData) async {
    final db = await database;
    return await db.insert('cargas', cargasData.toMap());
  }

  Future<int> updateCargas(CargaElectrica cargaData) async {
    final db = await database;
    return await db.update(
      'cargas',
      cargaData.toMap(),
      where: 'elemento = ?',
      whereArgs: [cargaData.elemento],
    );
  }

  Future<int> deleteCargas(int id) async {
    final db = await database;
    return await db.delete(
      'cargas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
