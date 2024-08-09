import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/entities.dart';
import 'package:presentation/notifiers/products/fav_products_local_provider.dart';
import 'package:presentation/notifiers/products/products_remote_notifier.dart';

import '../../widgets/card_item.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final products = ref.watch(productsRemoteProvider);

    return switch (products) {
      AsyncData(:final value) when value.isNotEmpty => _build(value, ref),
      AsyncLoading() =>
        const Center(child: CircularProgressIndicator.adaptive()),
      _ => const SizedBox(),
    };
  }

  Widget _build(List<Product> products, WidgetRef ref) => GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) => ProductCard(
          product: products[index],
          onTap: () => ref
              .read(favoritesProvider.notifier)
              .toggleFavorite(products[index]),
        ),
      );
}
