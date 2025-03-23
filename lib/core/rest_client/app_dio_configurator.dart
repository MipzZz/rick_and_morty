import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

/// {@template app_dio_configurator.class}
/// The base class with client configuration of [Dio].
/// {@endtemplate}
class AppDioConfigurator {
  /// {@macro app_dio_configurator.class}
  const AppDioConfigurator();

  /// Creating a client [Dio].
  Dio create({required String url}) {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    dio.options
      ..baseUrl = url
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..sendTimeout = timeout;

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();

        return client;
      },
    );

    return dio;
  }
}
