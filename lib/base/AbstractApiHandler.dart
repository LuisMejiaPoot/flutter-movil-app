import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Handler.dart';

abstract class AbstractApiHandler<U, T> implements Handler<U, T> {
  final http.Client httpClient;

  AbstractApiHandler({required this.httpClient});

  // Método auxiliar para serializar objetos (omitiendo logs)
  String toJson(Object obj) {
    return jsonEncode(obj);
  }

  @override
  Future<T> execute(U input) => doExecute(input);

  // Método abstracto que las clases hijas deben implementar
  Future<T> doExecute(U input);


  

  // Petición POST
  Future<String> webClientPost(String url, Object request, {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    };

    try {
      final response = await httpClient.post(
        uri,
        headers: defaultHeaders,
        body: toJson(request),
      );

      if (response.statusCode >= 400) {
        throw Exception('External service error (${response.statusCode}): ${response.body}');
      }

      return response.body;
    } catch (e) {
      throw Exception('Unexpected error in webClientPost: $e');
    }
  }

  // Petición POST Multipart (Usando http.MultipartRequest)
  Future<String> webClientPostMultipart(String url, Map<String, String> fields, {Map<String, String>? headers, List<http.MultipartFile>? files}) async {
    final uri = Uri.parse(url);
    final request = http.MultipartRequest('POST', uri);
    
    if (headers != null) {
      request.headers.addAll(headers);
    }
    request.headers['Accept'] = 'application/json';
    
    request.fields.addAll(fields);
    if (files != null) {
      request.files.addAll(files);
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 400) {
        throw Exception('External service error (${response.statusCode}): ${response.body}');
      }

      return response.body;
    } catch (e) {
      throw Exception('Unexpected error in webClientPostMultipart: $e');
    }
  }

  // Petición GET
  Future<String> webClientGet(String url, {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    final defaultHeaders = {
      'Accept': 'application/json',
      ...?headers,
    };

    try {
      final response = await httpClient.get(uri, headers: defaultHeaders);

      if (response.statusCode >= 400) {
        throw Exception('External service error (${response.statusCode}): ${response.body}');
      }

      return response.body;
    } catch (e) {
      throw Exception('Unexpected error in webClientGet: $e');
    }
  }

  // Petición DELETE
  Future<String> webClientDelete(String url, {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    final defaultHeaders = {
      'Accept': 'application/json',
      ...?headers,
    };

    try {
      final response = await httpClient.delete(uri, headers: defaultHeaders);

      if (response.statusCode >= 400) {
        throw Exception('External service error (${response.statusCode}): ${response.body}');
      }

      return response.body;
    } catch (e) {
      throw Exception('Unexpected error in webClientDelete: $e');
    }
  }

  // Petición PUT
  Future<String> webClientPut(String url, Object request, {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    };

    try {
      final response = await httpClient.put(
        uri,
        headers: defaultHeaders,
        body: toJson(request),
      );

      if (response.statusCode >= 400) {
        throw Exception('External service error (${response.statusCode}): ${response.body}');
      }

      return response.body;
    } catch (e) {
      throw Exception('Unexpected error in webClientPut: $e');
    }
  }
}