part of 'home_cubit.dart';
@immutable
abstract class HomeState {
  HomeState({required HomeState? state}) {
    topShopDto = state?.topShopDto;
    recentlyDto = state?.recentlyDto;
    topCategoriesDto = state?.topCategoriesDto;
    bannerSliderDto = state?.bannerSliderDto;
    quickDto = state?.quickDto;
    auctionDto = state?.auctionDto;
    searchShoppingDto = state?.searchShoppingDto;
    searchMercariDto = state?.searchMercariDto;
    searchRakutenDto = state?.searchRakutenDto;
    flashSaleDto = state?.flashSaleDto;
    cartDto = state?.cartDto;
    favoriteSearchDto = state?.favoriteSearchDto;
  }

  TopShopDto? topShopDto;
  FlashSaleDto?  flashSaleDto;
  RecentlyDto? recentlyDto;
  BannerSliderDto? bannerSliderDto;
  TopCategoriesDto? topCategoriesDto;
  QuickDto? quickDto;
  AuctionDto? auctionDto;
  SearchShoppingDto? searchShoppingDto;
  SearchMercariDto? searchMercariDto;
  SearchRakutenDto? searchRakutenDto;
  CartDto? cartDto;
  FavoriteSearchDto? favoriteSearchDto;

  void copy(HomeState? state) {
    topShopDto = state?.topShopDto;
    recentlyDto = state?.recentlyDto;
    topCategoriesDto = state!.topCategoriesDto;
    bannerSliderDto = state.bannerSliderDto;
    quickDto = state.quickDto;
    auctionDto = state.auctionDto;
    searchShoppingDto = state.searchShoppingDto;
    searchMercariDto = state.searchMercariDto;
    flashSaleDto = state.flashSaleDto;
    cartDto = state.cartDto;
    favoriteSearchDto = state.favoriteSearchDto;
  }


}

class DashboardInitial extends HomeState {
  DashboardInitial() : super(state: null);
}
class DashboardLoading extends HomeState {
  DashboardLoading() : super(state: null);
}
abstract class DashboardSuccessState extends HomeState {
  DashboardSuccessState({required super.state});
}

class TopShopDataLoading extends HomeState {
  TopShopDataLoading({required super.state});
}

class TopShopDataSuccess extends HomeState {
  TopShopDataSuccess({required super.state});
}
class FlashSaleDataSuccess extends DashboardSuccessState {
  FlashSaleDataSuccess({required super.state});
}
class FavoriteDataSuccess extends DashboardSuccessState {
  FavoriteDataSuccess({required super.state});
}
class CartDataSuccess extends DashboardSuccessState {
  CartDataSuccess({required super.state});
}
class TopCategoriesDataSuccess extends DashboardSuccessState {
  TopCategoriesDataSuccess({required super.state});
}
class RecentlyViewedDataSuccess extends DashboardSuccessState {
  RecentlyViewedDataSuccess({required super.state});
}
class BannerSliderDataSuccess extends DashboardSuccessState {
  BannerSliderDataSuccess({required super.state});
}
class QuickDataSuccess extends DashboardSuccessState {
  QuickDataSuccess({required super.state});
}
class AuctionDataSuccess extends DashboardSuccessState {
  AuctionDataSuccess({required super.state});
}
class SearchDataSuccess extends DashboardSuccessState {
  SearchDataSuccess({required super.state});
}
class SearchMercariDataSuccess extends DashboardSuccessState {
  SearchMercariDataSuccess({required super.state});
}
class SearchRakutenDataSuccess extends DashboardSuccessState {
  SearchRakutenDataSuccess({required super.state});
}