import 'dart:convert';

import 'package:flutter_application_api/base/AbstractServiceHandler.dart';
import 'package:flutter_application_api/product_by_id/ProductByIdApi.dart';
import 'package:flutter_application_api/products/Product.dart';

class ProductByIdService extends AbstractServiceHandler<int, Product> {
  final ProductByIdApi productByIdApi;

  ProductByIdService({required this.productByIdApi});

  // Atajo de conveniencia: delega en execute()
  Future<Product> getProductById(int id) {
    return execute(id);
  }

  // Lógica principal: llama al API y convierte el JSON en un objeto Product
  @override
  Future<Product> doExecute(int input) async {
    final body = await productByIdApi.execute(input);
    final json = jsonDecode(body) as Map<String, dynamic>;
    return Product.fromJson(json);
  }
}
