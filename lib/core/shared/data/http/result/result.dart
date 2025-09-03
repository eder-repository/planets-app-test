sealed class HttpResult<T> {
  const factory HttpResult.success(
    int statusCode,
    T data,
  ) = HttpSuccess<T>;

  const factory HttpResult.failed(
    int? statusCode,
    Object? error,
  ) = HttpFailed<T>;
}

class HttpSuccess<T> implements HttpResult<T> {
  const HttpSuccess(this.statusCode, this.data);
  final int statusCode;
  final T data;
}

class HttpFailed<T> implements HttpResult<T> {
  const HttpFailed(this.statusCode, this.error);

  final int? statusCode;
  final Object? error;
}
