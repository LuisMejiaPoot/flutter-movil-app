import 'dart:convert';

import 'package:flutter_application_api/base/AbstractServiceHandler.dart';
import 'package:flutter_application_api/products/Product.dart';
import 'package:flutter_application_api/products/ProductsApi.dart';

class ProductsService extends AbstractServiceHandler<void, List<Product>> {
  final ProductsApi productsApi;

  ProductsService({required this.productsApi});

  // Atajo de conveniencia: delega en execute()
  Future<List<Product>> getProducts() {
    return execute(null);
  }

  // Lógica principal: llama al API de productos y convierte la lista del JSON en objetos Product
  @override
  Future<List<Product>> doExecute(void input) async {
    final body = await productsApi.execute(null);
    final json = jsonDecode(body) as Map<String, dynamic>;
    final products = json['products'] as List<dynamic>;
    return products
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
