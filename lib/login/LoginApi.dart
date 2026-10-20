import 'dart:convert';

import 'package:flutter_application_api/base/AbstractApiHandler.dart';
import 'package:flutter_application_api/login/UserCredentialsDto.dart';

class LoginApi extends AbstractApiHandler<UserCredentialsDto, String> {
  LoginApi({required super.httpClient});

  static const String _url = 'https://dummyjson.com/auth/login';

  @override
  Future<String> doExecute(UserCredentialsDto input) async {
    // webClientPost maneja la petición POST y valida status >= 400
    return await webClientPost(_url, input.toJson());
  }
}