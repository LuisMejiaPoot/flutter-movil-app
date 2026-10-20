import 'package:flutter_application_api/base/AbstractApiHandler.dart';

class ProductsApi extends AbstractApiHandler<void, String> {
  ProductsApi({required super.httpClient});

  static const String _url = 'https://dummyjson.com/products';

  @override
  Future<String> doExecute(void input) {
    // webClientGet maneja la petición GET y valida status >= 400
    return webClientGet(_url);
  }
}
