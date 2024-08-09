import 'package:ecommerce_app/domain/entities/product_entity.dart';
import 'package:ecommerce_app/providers/notifiers/products/fav_products_local_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Image.network(
              product.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    IconButton(
                      icon: Consumer(builder: (context, ref, _) {
                        final isFav = ref
                            .watch(favoritesProvider)
                            .any((favProduct) => favProduct.id == product.id);
                        return Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                        );
                      }),
                      onPressed: onTap,
                    ),
                  ],
                ),
                Text(
                  product.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
