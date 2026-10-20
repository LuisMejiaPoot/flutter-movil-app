import 'package:flutter/material.dart';
import 'package:flutter_application_api/login/LoginApi.dart';
import 'package:flutter_application_api/login/LoginScreen.dart';
import 'package:flutter_application_api/login/LoginService.dart';
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
  runApp(MainApp(loginService: loginService, productsService: productsService));
}

class MainApp extends StatelessWidget {
  final LoginService loginService;
  final ProductsService productsService;

  const MainApp({
    super.key,
    required this.loginService,
    required this.productsService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(
        loginService: loginService,
        productsService: productsService,
      ),
    );
  }
}
