import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  const AuthInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    super.onRequest(options, handler);
  }
}
