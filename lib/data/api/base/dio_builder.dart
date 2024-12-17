import 'package:dio/dio.dart';

class DioBuilder {
  const DioBuilder._();

  static Dio createDio({
    BaseOptions? options,
    List<Interceptor> interceptors = const [],
  }) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: options?.connectTimeout,
        receiveTimeout: options?.receiveTimeout,
        sendTimeout: options?.sendTimeout,
        baseUrl: options?.baseUrl ?? '',
      ),
    );

    dio.interceptors.addAll(interceptors);

    return dio;
  }
}
