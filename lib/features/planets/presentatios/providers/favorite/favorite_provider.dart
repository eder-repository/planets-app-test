import 'package:planets_app_test/core/injector/repositories.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';
import 'package:riverpod/riverpod.dart';

part 'favorite_state.dart';

final setFavoriteProvider = NotifierProvider<FavoriteProvider, FavoriteState>(
  FavoriteProvider.new,
);

class FavoriteProvider extends Notifier<FavoriteState> {
  IPlanetsRepository get _repo => ref.read(Repositories.planets);

  @override
  FavoriteState build() {
    return const FavoriteLoading();
  }

  Future<void> setFavorite({
    required String planetId,
    required bool isFavorite,
  }) async {
    state = const FavoriteLoading();
    await _repo.setFavorite(planetId, isFavorite: isFavorite);
    state = const FavoriteLoaded();
  }
}
