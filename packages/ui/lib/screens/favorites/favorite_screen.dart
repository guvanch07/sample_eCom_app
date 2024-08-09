import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/entities.dart';
import 'package:presentation/notifiers/products/fav_products_local_provider.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final favorites = ref.watch(favoritesProvider);
    return favorites.isNotEmpty
        ? _build(favorites, ref)
        : const Center(child: Text('Empty'));
  }

  Widget _build(List<Product> value, WidgetRef ref) => ListView.builder(
        itemCount: value.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(value[index].name),
          subtitle: Text(value[index].description),
          leading: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(value[index].imageUrl)),
          trailing: IconButton(
              onPressed: () => ref
                  .read(favoritesProvider.notifier)
                  .toggleFavorite(value[index]),
              icon: const Icon(Icons.favorite)),
        ),
      );
}
