import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/core/rest_client/rest_client.dart';
import 'package:rick_and_morty/core/utils/typdef.dart';

/// {@macro rest_client}
@immutable
final class RestClientDio implements RestClient {
  /// {@macro rest_client}
  const RestClientDio({required Dio dio}) : _dio = dio;

  /// The base url for the client
  final Dio _dio;

  /// Sends a request to the server
  @override
  Future<JsonMap?> send({
    required String path,
    required String method,
    Object? body,
    Map<String, String>? headers,
    JsonMap? queryParams,
  }) async {
    try {
      final options = Options(
        headers: headers,
        method: method,
        contentType: 'application/json',
        responseType: ResponseType.json,
      );

      final response = await _dio.request<Object?>(
        path,
        queryParameters: queryParams,
        data: body,
        options: options,
      );

      return response.data as JsonMap?;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        Error.throwWithStackTrace(Exception('ConnectionException'), e.stackTrace);
      }
      if (e.response?.statusCode == 404) {
        return null;
      }
      if (e.response != null) {
        if (e.response!.data is JsonMap) {
          Error.throwWithStackTrace(Exception(e.error), e.stackTrace);
        }
      }
      Error.throwWithStackTrace(Exception(e.error), e.stackTrace);
    }
  }

  @override
  Future<JsonMap?> get(
    String path, {
    Map<String, String>? headers,
    Map<String, Object>? extra,
    JsonMap? queryParams,
  }) =>
      send(path: path, method: 'GET', headers: headers, queryParams: queryParams);

  @override
  Future<JsonMap?> post(
    String path, {
    required Object body,
    Map<String, String>? headers,
    Map<String, Object>? extra,
    JsonMap? queryParams,
  }) =>
      send(path: path, method: 'POST', body: body, headers: headers, queryParams: queryParams);

  @override
  Future<JsonMap?> put(
    String path, {
    JsonMap? body,
    Map<String, String>? headers,
    Map<String, Object>? extra,
    JsonMap? queryParams,
  }) =>
      send(path: path, method: 'PUT', body: body, headers: headers, queryParams: queryParams);

  @override
  Future<JsonMap?> delete(
    String path, {
    Object? body,
    Map<String, String>? headers,
    Map<String, Object>? extra,
    JsonMap? queryParams,
  }) =>
      send(path: path, method: 'DELETE', headers: headers, queryParams: queryParams, body: body);

  @override
  Future<JsonMap?> patch(
    String path, {
    required JsonMap body,
    Map<String, String>? headers,
    Map<String, Object>? extra,
    JsonMap? queryParams,
  }) =>
      send(path: path, method: 'PATCH', body: body, headers: headers, queryParams: queryParams);
}
