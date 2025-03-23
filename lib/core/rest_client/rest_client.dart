import 'package:rick_and_morty/core/utils/typdef.dart';

/// {@template rest_client}
/// A REST client for making HTTP requests.
/// {@endtemplate}
abstract interface class RestClient {
  /// Sends a request to the server
  Future<JsonMap?> send({
    required String path,
    required String method,
    Object? body,
    Map<String, String>? headers,
    JsonMap? queryParams,
  });

  /// Sends a GET request to the given [path].
  Future<JsonMap?> get(
    String path, {
    Map<String, String>? headers,
    JsonMap? queryParams,
  });

  /// Sends a POST request to the given [path].
  Future<JsonMap?> post(
    String path, {
    required Object body,
    Map<String, String>? headers,
    JsonMap? queryParams,
  });

  /// Sends a PUT request to the given [path].
  Future<JsonMap?> put(
    String path, {
    JsonMap? body,
    Map<String, String>? headers,
    JsonMap? queryParams,
  });

  /// Sends a DELETE request to the given [path].
  Future<JsonMap?> delete(
    String path, {
    Object? body,
    Map<String, String>? headers,
    JsonMap? queryParams,
  });

  /// Sends a PATCH request to the given [path].
  Future<JsonMap?> patch(
    String path, {
    required JsonMap body,
    Map<String, String>? headers,
    JsonMap? queryParams,
  });
}
