import 'dart:async';
import 'dart:convert' show json;

import 'package:data/services/db_service.dart';
import 'package:domain/entities/product_entity.dart';
import 'package:domain/repository/products_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

const _fav = 'favorites';

final class ProductsRepository implements IProductsRepository {
  final DatabaseService databaseService;

  const ProductsRepository({required this.databaseService});

  @override
  Future<List<Product>> loadProducts() async {
    final jsonString = await rootBundle.loadString('assets/products.json');
    final jsonResponse = await compute(json.decode, jsonString) as List;

    return jsonResponse
        .map(
          (product) => Product(
            id: product['id'],
            name: product['name'],
            description: product['description'],
            imageUrl: product['imageUrl'],
            isFavorite: product['isFavorite'],
          ),
        )
        .toList();
  }

  @override
  Future<List<Product>> getFavorites() async {
    final db = await databaseService.database;
    final maps = await db.query(_fav);
    return await compute(_processMapsToProducts, maps);
  }

  @override
  Future<void> addFavorite(Product product) async {
    final db = await databaseService.database;
    final data = {
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'imageUrl': product.imageUrl,
    };
    await db.insert(_fav, data);
  }

  @override
  Future<void> removeFavorite(String id) async {
    final db = await databaseService.database;
    await db.delete(_fav, where: 'id = ?', whereArgs: [id]);
  }

  List<Product> _processMapsToProducts(List<Map<String, dynamic>> maps) => maps
      .map((map) => Product(
            id: map['id'] as String,
            name: map['name'] as String,
            description: map['description'] as String,
            imageUrl: map['imageUrl'] as String,
            isFavorite: true,
          ))
      .toList();
}
