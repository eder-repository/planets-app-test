sealed class FailureType {
  FailureType({required this.message});

  factory FailureType.unauthorized({required String message}) =
      _UnauthorizedFailure;
  factory FailureType.cancelled({required String message}) = _CancelledFailure;
  factory FailureType.unknown({required String message}) = _UnknownFailure;
  final String message;
}

class _UnauthorizedFailure extends FailureType {
  _UnauthorizedFailure({required super.message});
}

class _CancelledFailure extends FailureType {
  _CancelledFailure({required super.message});
}

class _UnknownFailure extends FailureType {
  _UnknownFailure({required super.message});
}
