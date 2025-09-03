sealed class HttpRequestFailure implements Exception {
  const factory HttpRequestFailure.unauthorized() = _Unauthorized;
  const factory HttpRequestFailure.internalServer() = _InternalServer;
  const factory HttpRequestFailure.serviceUnavailable() = _ServiceUnavailable;
  const factory HttpRequestFailure.unhandledException() = _UnhandledException;
  const factory HttpRequestFailure.network() = _Network;
  const factory HttpRequestFailure.notFound() = NotFound;
  const factory HttpRequestFailure.badRequest(String message) = _BadRequest;
}

class _Unauthorized implements HttpRequestFailure {
  const _Unauthorized();
}

class _InternalServer implements HttpRequestFailure {
  const _InternalServer();
}

class _ServiceUnavailable implements HttpRequestFailure {
  const _ServiceUnavailable();
}

class _UnhandledException implements HttpRequestFailure {
  const _UnhandledException();
}

class _BadRequest implements HttpRequestFailure {
  const _BadRequest(this.message);
  final String message;

  @override
  String toString() => message;
}

class _Network implements HttpRequestFailure {
  const _Network();
}

class NotFound implements HttpRequestFailure {
  const NotFound();
}
