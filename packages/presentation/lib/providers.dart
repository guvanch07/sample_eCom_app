import 'package:data/repository/auth_repository_impl.dart';
import 'package:data/repository/products_repository_imp.dart';
import 'package:data/services/db_service.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/products_repository.dart';
import 'package:riverpod/riverpod.dart';

final _dbProvider = Provider<DatabaseService>((_) => DatabaseService());

final productsProvider = Provider<IProductsRepository>(
  (ref) => ProductsRepository(
      databaseService: ref.watch<DatabaseService>(_dbProvider)),
);

final authProvider = Provider<IAuthRepository>(
  (ref) => AuthRepository(
    databaseService: ref.watch<DatabaseService>(_dbProvider),
  ),
);
