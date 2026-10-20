import 'package:flutter_application_api/base/CustomException.dart';
import 'package:flutter_application_api/base/Handler.dart';

abstract class AbstractServiceHandler<U, T> implements Handler<U, T> {
  @override
  Future<T> execute(U input) async {
    try {
      // Lógica principal delegada al método abstracto doExecute
      final T result = doExecute(input);
      return result;
    } on CustomException catch (e) {
      // Se re-lanza la excepción personalizada tal como en Java
      rethrow;
    } catch (e, stackTrace) {
      // Envoltura de la excepción genérica similar a RuntimeException
      final className = runtimeType.toString();
      throw Exception('Error executing service=$className: $e');
    }
  }

  // Método abstracto que las clases hijas deben implementar
  T doExecute(U input);
}