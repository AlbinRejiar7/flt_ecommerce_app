import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteState());

  static const String _favoritesKey = 'favorite_products';

  Future<void> loadFavorites() async {
    final preferences = await SharedPreferences.getInstance();

    final storedIds = preferences.getStringList(_favoritesKey) ?? [];

    final favoriteIds = storedIds.map(int.parse).toSet();

    emit(FavoriteState(favoriteIds: favoriteIds));
  }

  Future<void> toggleFavorite(int productId) async {
    final updatedFavorites = Set<int>.from(state.favoriteIds);

    if (updatedFavorites.contains(productId)) {
      updatedFavorites.remove(productId);
    } else {
      updatedFavorites.add(productId);
    }

    emit(FavoriteState(favoriteIds: updatedFavorites));

    final preferences = await SharedPreferences.getInstance();

    await preferences.setStringList(
      _favoritesKey,
      updatedFavorites.map((id) => id.toString()).toList(),
    );
  }
}
