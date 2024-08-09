import 'dart:async';

import 'package:domain/entities/product_entity.dart';
import 'package:domain/repository/products_repository.dart';
import 'package:riverpod/riverpod.dart';

import '../../providers.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Product>>(
  (ref) => FavoritesNotifier(ref.watch(productsProvider)),
);

class FavoritesNotifier extends StateNotifier<List<Product>> {
  final IProductsRepository productsRepository;

  FavoritesNotifier(this.productsRepository) : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    state = await productsRepository.getFavorites();
  }

  Future<void> toggleFavorite(Product product) async {
    final isFavorite = state.any((favProduct) => favProduct.id == product.id);

    if (isFavorite) {
      unawaited(productsRepository.removeFavorite(product.id));
      state = state.where((favProduct) => favProduct.id != product.id).toList();
    } else {
      unawaited(productsRepository.addFavorite(product));
      state = [...state, product.copyWith(isFavorite: true)];
    }
  }
}
