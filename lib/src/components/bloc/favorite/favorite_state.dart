part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {
  FavoriteState({required FavoriteState? state}) {
    favoriteDto = state?.favoriteDto;
    data = state?.data;
    isFavoriteSeller = state?.isFavoriteSeller;
    itemFavoriteSeller = state?.itemFavoriteSeller;
  }
  FavoriteDto? favoriteDto;
  FavoriteSellerItemDto? itemFavoriteSeller;
  List<FavoriteItems>? data;
  String? isFavoriteSeller;
  void copy(FavoriteState? state) {
    favoriteDto = state?.favoriteDto;
    data = state?.data;
    isFavoriteSeller = state?.isFavoriteSeller;
    itemFavoriteSeller = state?.itemFavoriteSeller;
  }
}

class FavoriteInitial extends FavoriteState {
  FavoriteInitial({required super.state});
}
class FavoriteLoading extends FavoriteState {
  FavoriteLoading({required super.state});
}
class FavoriteItemSuccess extends FavoriteState {
  FavoriteItemSuccess({required super.state});
}
class FavoritesSuccess extends FavoriteState {
  FavoritesSuccess({required super.state});
}
class FavoritesSellerSuccess extends FavoriteState {
  FavoritesSellerSuccess({required super.state});
}

class GetFavoritesSellerSuccess extends FavoriteState {
  GetFavoritesSellerSuccess({required super.state});
}
class DeletedFavoritesSuccess extends FavoriteState {
  DeletedFavoritesSuccess({required super.state});
}
class FavoritesSearchLoading extends FavoriteState {
  FavoritesSearchLoading({required super.state});
}
class FavoritesSearchSuccess extends FavoriteState {
  FavoritesSearchSuccess({required super.state});
}
class FavoritesSearchEmpty extends FavoriteState {
  FavoritesSearchEmpty({required super.state});
}
class FavoritesSearchFailed extends FavoriteState {
  FavoritesSearchFailed({required super.state});
}
