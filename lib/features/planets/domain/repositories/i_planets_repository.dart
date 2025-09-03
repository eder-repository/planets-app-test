import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';

abstract interface class IPlanetsRepository {
  FutureHttpRequest<List<Planet>> all();
  Future<List<String>> getFavoriteIds();
  Future<bool> setFavorite(String planetId, {bool isFavorite = false});
}
