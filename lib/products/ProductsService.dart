import 'dart:convert';

import 'package:flutter_application_api/products/Product.dart';
import 'package:flutter_application_api/products/ProductsApi.dart';

class ProductsService {
  final ProductsApi productsApi;

  ProductsService({required this.productsApi});

  // Llama al API de productos y convierte la lista del JSON en objetos Product
  Future<List<Product>> getProducts() async {
    final body = await productsApi.execute(null);
    final json = jsonDecode(body) as Map<String, dynamic>;
    final products = json['products'] as List<dynamic>;
    return products
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
