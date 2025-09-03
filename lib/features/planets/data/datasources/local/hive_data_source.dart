import 'package:hive/hive.dart';

class HiveDataSource {
  HiveDataSource() {
    init();
  }

  static const _favoritesBox = 'planet_favorites';
  Box<bool>? _box;

  Future<void> init() async {
    _box ??= await Hive.openBox<bool>(_favoritesBox);
  }

  Future<bool> setFavorite(String planetId, {bool isFavorite = false}) async {
    final box = _ensureBox();
    if (isFavorite) {
      await box.put(planetId, true);
    } else {
      await box.delete(planetId);
    }
    return true;
  }

  bool isFavorite(String planetId) {
    final box = _ensureBox();
    return box.get(planetId, defaultValue: false) ?? false;
  }

  List<String> getFavoriteIds() {
    final box = _ensureBox();
    return box.keys.cast<String>().toList(growable: false);
  }

  Box<bool> _ensureBox() {
    final b = _box;
    if (b == null || !b.isOpen) {
      throw StateError(
        'Debes llamar init() antes de usar PlanetsLocalDatasource.',
      );
    }
    return b;
  }
}
