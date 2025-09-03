import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/features/planets/data/data.dart';
import 'package:planets_app_test/features/planets/data/datasources/local/hive_data_source.dart';

final class DataSources {
  const DataSources._();

  static final planetsRemote = Provider<IPlanetsRemoteDatasource>(
    (ref) => PlanetsRemoteDatasource(http: ref.read(Providers.http)),
  );

  static final planetsLocal = Provider<IPlanetsLocalDatasource>(
    (ref) => PlanetsLocalDatasource(localStorage: HiveDataSource()),
  );
}
