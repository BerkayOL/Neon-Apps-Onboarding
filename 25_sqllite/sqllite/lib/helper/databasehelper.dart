import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/asgardian.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'asgardians.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE asgardians(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            surname TEXT,
            age INTEGER,
            email TEXT,
            otherDetails TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertAsgardian(Asgardian asgardian) async {
    final db = await database;
    return await db.insert('asgardians', asgardian.toJson());
  }

  Future<List<Asgardian>> getAsgardians() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('asgardians');
    return List.generate(maps.length, (i) {
      return Asgardian.fromJson(maps[i]);
    });
  }
}
