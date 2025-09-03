import 'package:planets_app_test/core/injector/repositories.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';
import 'package:riverpod/riverpod.dart';

part 'favorite_list_state.dart';

final favoriteListProvider =
    NotifierProvider<FavoriteListProvider, FavoriteListState>(
      FavoriteListProvider.new,
    );

class FavoriteListProvider extends Notifier<FavoriteListState> {
  IPlanetsRepository get _repo => ref.read(Repositories.planets);

  @override
  FavoriteListState build() {
    getFavoriteIds();
    return const FavoriteListLoading();
  }

  Future<void> getFavoriteIds() async {
    state = const FavoriteListLoading();
    final result = await _repo.getFavoriteIds();
    state = FavoriteListLoaded(favoriteIds: result);
  }
}
