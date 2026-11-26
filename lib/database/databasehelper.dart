import 'package:path/path.dart';
import 'package:safestep/models/caregivermodel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  static const String _dbName = 'safestep.db';
  static const int _dbVersion = 1;
  static const String tableCaregivers = 'caregivers';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableCaregivers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phoneNumber TEXT NOT NULL,
        isPrimary INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  Future<int> insertCaregiver(Caregiver caregiver) async {
    final Database db = await database;
    if (caregiver.isPrimary) {
      return db.transaction((txn) async {
        await txn.update(tableCaregivers, {'isPrimary': 0});
        return txn.insert(
          tableCaregivers,
          caregiver.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
    }
    return db.insert(
      tableCaregivers,
      caregiver.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Caregiver>> getCaregivers() async {
    final Database db = await database;
    final maps = await db.query(
    tableCaregivers,
    orderBy: 'isPrimary DESC, id DESC',
    );
    return maps.map((map) => Caregiver.fromMap(map)).toList();
  }

  Future<int> updateCaregiver(Caregiver caregiver) async {
    final Database db = await database;
    if (caregiver.id == null) return 0;

    if (caregiver.isPrimary) {
      return db.transaction((txn) async {
        await txn.update(tableCaregivers, {'isPrimary': 0});
        return txn.update(
          tableCaregivers,
          caregiver.toMap(),
          where: 'id = ?',
          whereArgs: [caregiver.id],
        );
      });
    }

    return db.update(
      tableCaregivers,
      caregiver.toMap(),
      where: 'id = ?',
      whereArgs: [caregiver.id],
    );
  }

  Future<int> setPrimaryCaregiver(int caregiverId) async {
    final Database db = await database;
    return db.transaction((txn) async {
      await txn.update(tableCaregivers, {'isPrimary': 0});
      return txn.update(
        tableCaregivers,
        {'isPrimary': 1},
        where: 'id = ?',
        whereArgs: [caregiverId],
      );
    });
  }

  Future<int> deleteCaregiver(int id) async {
    final Database db = await database;
    return db.delete(
      tableCaregivers,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDatabase() async {
    final Database? db = _database;
    if (db != null && db.isOpen) {
      await db.close();
      _database = null;
    }
  }
}