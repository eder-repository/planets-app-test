import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/features/planets/data/data.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';

class PlanetsRepository implements IPlanetsRepository {
  PlanetsRepository({
    required IPlanetsRemoteDatasource remoteDatasource,
    required IPlanetsLocalDatasource localDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDatasource;

  final IPlanetsRemoteDatasource _remoteDatasource;
  final IPlanetsLocalDatasource _localDatasource;

  @override
  FutureHttpRequest<List<Planet>> all() async {
    final result = await _remoteDatasource.all();

    return switch (result) {
      Success(:final data) => Success(data: data.mapList((e) => e.toEntity())),
      Failure(:final failure) => Failure(failure: failure),
    };
  }

  @override
  Future<List<String>> getFavoriteIds() async {
    final result = await _localDatasource.getFavoriteIds();
    return result;
  }

  @override
  Future<bool> setFavorite(String planetId, {bool isFavorite = false}) {
    final result = _localDatasource.setFavorite(
      planetId,
      isFavorite: isFavorite,
    );
    return result;
  }
}
