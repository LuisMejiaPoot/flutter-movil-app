import 'package:flutter_application_api/base/AbstractApiHandler.dart';

class ProductByIdApi extends AbstractApiHandler<int, String> {
  ProductByIdApi({required super.httpClient});

  static const String _url = 'https://dummyjson.com/products';

  @override
  Future<String> doExecute(int input) async {
    // webClientGet maneja la petición GET y valida status >= 400
    return webClientGet('$_url/$input');
  }
}
