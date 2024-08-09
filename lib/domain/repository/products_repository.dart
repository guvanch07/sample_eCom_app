import 'package:ecommerce_app/domain/entities/product_entity.dart';

abstract interface class IProductsRepository {
  Future<List<Product>> loadProducts();
  Future<void> removeFavorite(String id);
  Future<List<Product>> getFavorites();
  Future<void> addFavorite(Product product);
}
