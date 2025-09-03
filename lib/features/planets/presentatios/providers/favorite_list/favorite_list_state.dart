part of 'favorite_list_provider.dart';

sealed class FavoriteListState {
  const FavoriteListState();
}

class FavoriteListLoading extends FavoriteListState {
  const FavoriteListLoading();
}

class FavoriteListLoaded extends FavoriteListState {
  const FavoriteListLoaded({
    required this.favoriteIds,
  });
  final List<String> favoriteIds;
}

class FavoriteListError extends FavoriteListState {
  const FavoriteListError();
}
