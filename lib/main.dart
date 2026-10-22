import 'package:flutter/material.dart';
import 'package:flutter_application_api/login/LoginApi.dart';
import 'package:flutter_application_api/login/LoginScreen.dart';
import 'package:flutter_application_api/login/LoginService.dart';
import 'package:flutter_application_api/product_by_id/ProductByIdApi.dart';
import 'package:flutter_application_api/product_by_id/ProductByIdService.dart';
import 'package:flutter_application_api/products/ProductsApi.dart';
import 'package:flutter_application_api/products/ProductsService.dart';
import 'package:http/http.dart' as http;

void main() {
  final httpClient = http.Client();
  final loginService = LoginService(
    loginApi: LoginApi(httpClient: httpClient),
  );
  final productsService = ProductsService(
    productsApi: ProductsApi(httpClient: httpClient),
  );
  final productByIdService = ProductByIdService(
    productByIdApi: ProductByIdApi(httpClient: httpClient),
  );
  runApp(
    MainApp(
      loginService: loginService,
      productsService: productsService,
      productByIdService: productByIdService,
    ),
  );
}

class MainApp extends StatelessWidget {
  final LoginService loginService;
  final ProductsService productsService;
  final ProductByIdService productByIdService;

  const MainApp({
    super.key,
    required this.loginService,
    required this.productsService,
    required this.productByIdService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(
        loginService: loginService,
        productsService: productsService,
        productByIdService: productByIdService,
      ),
    );
  }
}
