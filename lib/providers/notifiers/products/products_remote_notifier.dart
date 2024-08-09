import 'package:ecommerce_app/domain/entities/product_entity.dart';
import 'package:ecommerce_app/domain/repository/products_repository.dart';
import 'package:ecommerce_app/providers/providers.dart';
import 'package:riverpod/riverpod.dart';

final productsRemoteProvider = FutureProvider.autoDispose<List<Product>>(
    (ref) => ref.watch<IProductsRepository>(productsProvider).loadProducts());
