import 'package:planets_app_test/core/core.dart';

typedef Json = Map<String, dynamic>;

typedef FutureEither<L, R> = Future<Either<L, R>>;

typedef FutureException<R> = FutureEither<Exception, R>;
typedef FutureHttpRequest<R> = FutureEither<HttpRequestFailure, R>;

typedef StreamHttpRequest<T> = Stream<Result<T>>;
