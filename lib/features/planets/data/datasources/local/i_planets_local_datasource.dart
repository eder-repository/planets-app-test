// ignore_for_file: one_member_abstracts

abstract interface class IPlanetsLocalDatasource {
  Future<bool> setFavorite(String planetId, {bool isFavorite});
  Future<List<String>> getFavoriteIds();
}
