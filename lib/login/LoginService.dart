import 'dart:convert';

import 'package:flutter_application_api/login/LoginApi.dart';
import 'package:flutter_application_api/login/UserCredentialsDto.dart';

class LoginService {
  final LoginApi loginApi;

  LoginService({required this.loginApi});

  // Llama al API de login y convierte el JSON de respuesta en AuthResponseDto
  Future<AuthResponseDto> login(String username, String password) async {
    final credentials = UserCredentialsDto(username: username, password: password);
    final body = await loginApi.execute(credentials);
    final json = jsonDecode(body) as Map<String, dynamic>;
    return AuthResponseDto.fromJson(json);
  }
}
