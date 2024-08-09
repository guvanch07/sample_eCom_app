import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'sql_queries.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._();
  static Database? _database;

  DatabaseService._();

  factory DatabaseService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'shop.db');
    return openDatabase(path, onCreate: (db, version) async {
      await db.execute(Sql.favoriteQuery);
      await db.execute(Sql.authQuery);
    }, version: 1);
  }
}
