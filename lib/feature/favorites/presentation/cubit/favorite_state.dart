class FavoriteState {
  final Set<int> favoriteIds;

  const FavoriteState({this.favoriteIds = const {}});

  bool isFavorite(int productId) {
    return favoriteIds.contains(productId);
  }
}
