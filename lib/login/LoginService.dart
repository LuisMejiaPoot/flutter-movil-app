import 'dart:convert';

import 'package:flutter_application_api/base/AbstractServiceHandler.dart';
import 'package:flutter_application_api/login/LoginApi.dart';
import 'package:flutter_application_api/login/UserCredentialsDto.dart';

class LoginService extends AbstractServiceHandler<UserCredentialsDto, AuthResponseDto> {
  final LoginApi loginApi;

  LoginService({required this.loginApi});

  // Atajo de conveniencia: arma las credenciales y delega en execute()
  Future<AuthResponseDto> login(String username, String password) {
    final credentials = UserCredentialsDto(username: username, password: password);
    return execute(credentials);
  }

  // Lógica principal: llama al API de login y convierte el JSON en AuthResponseDto
  @override
  Future<AuthResponseDto> doExecute(UserCredentialsDto input) async {
    final body = await loginApi.execute(input);
    final json = jsonDecode(body) as Map<String, dynamic>;
    return AuthResponseDto.fromJson(json);
  }
}
