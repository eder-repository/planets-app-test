import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app_test/core/injector/data_sources.dart';
import 'package:planets_app_test/features/planets/data/data.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';

final class Repositories {
  const Repositories._();

  static final planets = Provider<IPlanetsRepository>(
    (ref) => PlanetsRepository(
      remoteDatasource: ref.read(DataSources.planetsRemote),
      localDatasource: ref.read(DataSources.planetsLocal),
    ),
  );
}
