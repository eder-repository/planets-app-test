import 'dart:io';

import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/core/shared/data/http/exceptions_models.dart';
import 'package:planets_app_test/core/shared/data/http/failures/failures.dart';
import 'package:planets_app_test/core/shared/data/http/result/result.dart';

const _network = HttpRequestFailure.network();
const _unauthorized = HttpRequestFailure.unauthorized();
const _internalServer = HttpRequestFailure.internalServer();
const _serviceUnavailable = HttpRequestFailure.serviceUnavailable();
const _unhandledException = HttpRequestFailure.unhandledException();
const _notFound = HttpRequestFailure.notFound();

HttpRequestFailure _badRequest(Object? error) {
  try {
    final reason = BadRequestErrorInfo.fromJson(error! as Json);
    return HttpRequestFailure.badRequest(reason.message);
  } catch (_) {
    return const HttpRequestFailure.badRequest('Unknown bad request error');
  }
}

FutureHttpRequest<T> performHttpRequest<T>(Future<HttpResult<T>> future) async {
  final result = await future;

  return switch (result) {
    HttpSuccess(:final data) => Success(data: data),
    HttpFailed(:final error) when _socket(error) => Failure(failure: _network),
    HttpFailed(:final statusCode) => switch (statusCode) {
      HttpStatus.unauthorized => Failure(failure: _unauthorized),
      HttpStatus.internalServerError => Failure(failure: _internalServer),
      HttpStatus.serviceUnavailable => Failure(failure: _serviceUnavailable),
      HttpStatus.notFound => Failure(failure: _notFound),
      HttpStatus.badRequest => Failure(failure: _badRequest(result.error)),
      _ => Failure(failure: _unhandledException),
    },
  };
}

bool _socket(Object? error) => error is SocketException;
