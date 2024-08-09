import 'package:domain/entities/product_entity.dart';
import 'package:domain/repository/products_repository.dart';
import 'package:riverpod/riverpod.dart';

import '../../providers.dart';

final productsRemoteProvider = FutureProvider.autoDispose<List<Product>>(
    (ref) => ref.watch<IProductsRepository>(productsProvider).loadProducts());
