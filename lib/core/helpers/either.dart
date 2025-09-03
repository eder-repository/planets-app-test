import 'package:planets_app_test/core/helpers/failure.dart';

sealed class Either<L, R> {}

class Success<L, R> implements Either<L, R> {
  Success({required this.data});
  final R data;
}

class Failure<L, R> implements Either<L, R> {
  Failure({required this.failure});
  final L failure;
}

// Para Stream (nuevo)
sealed class Result<T> {}

class SuccessResult<T> extends Result<T> {
  SuccessResult({required this.data});
  final T data;
}

class FailureResult<T> extends Result<T> {
  FailureResult({required this.failure});
  final FailureType failure;
}
