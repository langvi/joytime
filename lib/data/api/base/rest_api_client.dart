import 'package:dio/dio.dart';

enum RequestMethod { get, post, put, delete, patch }

abstract class RestApiClient {
  RestApiClient({
    required this.dio,
  });

  final Dio dio;
  Map<String, String>? get headers;
  Future request({
    required RequestMethod method,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Options? options,
  }) async {
    var res = await _requestByMethod(
      method: method,
      path: path.startsWith(dio.options.baseUrl)
          ? path.substring(dio.options.baseUrl.length)
          : path,
      queryParameters: queryParameters,
      body: body,
      options: Options(
        headers: headers,
        contentType: options?.contentType,
        responseType: options?.responseType,
        sendTimeout: options?.sendTimeout,
        receiveTimeout: options?.receiveTimeout,
      ),
    );
    return res.data;
  }

  Future<Response<dynamic>> _requestByMethod({
    required RequestMethod method,
    required String path,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Options? options,
  }) {
    switch (method) {
      case RequestMethod.get:
        return dio.get(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case RequestMethod.post:
        return dio.post(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case RequestMethod.patch:
        return dio.patch(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case RequestMethod.put:
        return dio.put(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case RequestMethod.delete:
        return dio.delete(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
    }
  }
}
