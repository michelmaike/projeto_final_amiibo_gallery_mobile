import 'package:hive/hive.dart';
import '../models/favorite_model.dart';
import '../models/card_model.dart';

class FavoriteService {
  final Box<FavoriteModel> _box = Hive.box<FavoriteModel>('favorites');

  Future<void> addFavorite(FavoriteModel favorite) async {
    final key = '${favorite.username}_${favorite.amiiboId}';
    await _box.put(key, favorite);
  }

  Future<void> removeFavorite(String username, String amiiboId) async {
    final key = '${username}_${amiiboId}';
    await _box.delete(key);
  }

  List<FavoriteModel> getFavoritesByUser(String username) {
    return _box.values.where((fav) => fav.username == username).toList();
  }

  bool isFavorite(String username, String amiiboId) {
    final key = '${username}_${amiiboId}';
    return _box.containsKey(key);
  }

  int getFavoriteCount(String username) {
    return _box.values.where((fav) => fav.username == username).length;
  }
}
