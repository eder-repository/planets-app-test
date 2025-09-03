part of 'favorite_provider.dart';

sealed class FavoriteState {
  const FavoriteState();
}

class FavoriteLoading extends FavoriteState {
  const FavoriteLoading();
}

class FavoriteLoaded extends FavoriteState {
  const FavoriteLoaded();
}

class FavoriteError extends FavoriteState {
  const FavoriteError();
}
