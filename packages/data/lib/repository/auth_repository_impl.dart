import 'package:domain/repository/auth_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../services/db_service.dart';

const _users = 'users';

final class AuthRepository implements IAuthRepository {
  final DatabaseService databaseService;

  const AuthRepository({required this.databaseService});

  @override
  Future<int?> createUser(String username, String password) async {
    final db = await databaseService.database;
    final data = {
      'username': username,
      'password': password,
    };
    return await db.insert(
      _users,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<Map<String, dynamic>?> getUser(String username) async {
    final db = await databaseService.database;

    final result = await db.query(
      _users,
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty ? result.first : null;
  }
}
