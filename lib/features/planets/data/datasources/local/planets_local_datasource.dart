import 'package:planets_app_test/features/planets/data/data.dart';
import 'package:planets_app_test/features/planets/data/datasources/local/hive_data_source.dart';

class PlanetsLocalDatasource implements IPlanetsLocalDatasource {
  PlanetsLocalDatasource({required HiveDataSource localStorage})
    : _localStorage = localStorage;

  final HiveDataSource _localStorage;

  @override
  Future<List<String>> getFavoriteIds() async {
    return Future.value(_localStorage.getFavoriteIds());
  }

  @override
  Future<bool> setFavorite(String planetId, {bool isFavorite = false}) {
    final result = _localStorage.setFavorite(planetId, isFavorite: isFavorite);
    return Future.value(result);
  }
}
