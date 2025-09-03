// ignore_for_file: avoid_redundant_argument_values
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app_test/core/core.dart';

final class Providers {
  const Providers._();

  static final env = Provider<Environments>(
    (_) => throw UnimplementedError(),
  );

  static final Provider<Http> http = Provider(
    (ref) {
      final enableLogging = ref.read(Providers.env).enableLogging;
      final baseOptions = BaseOptions(
        baseUrl: const String.fromEnvironment('baseUrl'),
      );
      final dio = Dio(baseOptions);
      dio.interceptors.addAll([
        const AuthInterceptor(),
        RetryInterceptor(dio: dio, enableLogging: enableLogging),
      ]);
      return Http(dio: dio, enableLogging: enableLogging);
    },
  );
}
