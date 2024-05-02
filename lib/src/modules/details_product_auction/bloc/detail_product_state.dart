part of 'detail_product_cubit.dart';

@immutable
abstract class DetailProductState {
  DetailProductState({required DetailProductState? state}) {
    detailDto = state?.detailDto;
    rakutenDetailDto = state?.rakutenDetailDto;
    marcariDetailDto = state?.marcariDetailDto;
    yShoppingDetailDto = state?.yShoppingDetailDto;

    recentlyDto = state?.recentlyDto;
    wareHouseDataDto = state?.wareHouseDataDto;
    relatesDto = state?.relatesDto;
    shipModeDto = state?.shipModeDto;
    suggestionsDto = state?.suggestionsDto;

    sellerDetailAuctionDto = state?.sellerDetailAuctionDto;
    sellerInfoAuctionDto = state?.sellerInfoAuctionDto;
    suggestionsShoppingDto = state?.suggestionsShoppingDto;
    suggestionRakutenDto = state?.suggestionRakutenDto;
    numberItemCart = state?.numberItemCart;
  }

  DetailDto? detailDto;
  RakutenDetailItemDto? rakutenDetailDto;
  MarcariDetailDto? marcariDetailDto;
  YShoppingDetailDto? yShoppingDetailDto;
  RecentlyDto? recentlyDto;
  List<ShipModeDto>? shipModeDto;
  List<WareHouseDataDto>? wareHouseDataDto;
  List<RelatesDto>? relatesDto;
  List<RelatesDto>? suggestionsDto;
  SellerDetailAuctionDto? sellerDetailAuctionDto;
  SellerInfoAuctionDto? sellerInfoAuctionDto;
  SearchShoppingDto? suggestionsShoppingDto;
  SuggestionRakutenDto? suggestionRakutenDto;
  int? numberItemCart;

  void copy(DetailProductState? state) {
    detailDto = state?.detailDto;
    rakutenDetailDto = state?.rakutenDetailDto;
    marcariDetailDto = state?.marcariDetailDto;
    yShoppingDetailDto = state?.yShoppingDetailDto;
    recentlyDto = state?.recentlyDto;
    relatesDto = state?.relatesDto;
    shipModeDto = state?.shipModeDto;
    wareHouseDataDto = state?.wareHouseDataDto;
    suggestionsDto = state?.suggestionsDto;
    sellerDetailAuctionDto = state?.sellerDetailAuctionDto;
    sellerInfoAuctionDto = state?.sellerInfoAuctionDto;
    suggestionsShoppingDto = state?.suggestionsShoppingDto;
    suggestionRakutenDto = state?.suggestionRakutenDto;
    numberItemCart = state?.numberItemCart;
  }
}

class DetailProductInitial extends DetailProductState {
  DetailProductInitial({required super.state});
}
class DetailProductLoading extends DetailProductState {
  DetailProductLoading({required super.state});
}
class DetailProductInfoDataSuccess extends DetailProductState {
  DetailProductInfoDataSuccess({required super.state});
}

class DataSuccessProduct extends DetailProductInfoDataSuccess {
  DataSuccessProduct({required super.state});
}
class DataDetailsSuccess extends DataSuccessProduct {
  DataDetailsSuccess({required super.state});
}

class RecentlyViewedDataSuccess extends DataSuccessProduct {
  RecentlyViewedDataSuccess({required super.state});
}
class RelatesDataSuccess extends DataSuccessProduct {
  RelatesDataSuccess({required super.state});
}
class SuggestionsDataSuccess extends DataSuccessProduct {
  SuggestionsDataSuccess({required super.state});
}
class WareHouseDataSuccess extends DataSuccessProduct {
  WareHouseDataSuccess({required super.state});
}
class FavoriteDataSuccess extends DataSuccessProduct {
  FavoriteDataSuccess({required super.state});
}
class CartDataSuccess extends DataSuccessProduct {
  CartDataSuccess({required super.state});
}
class DataSellerDetailSuccessProduct extends DetailProductInfoDataSuccess {
  DataSellerDetailSuccessProduct({required super.state});
}
class SellerDetailProductSuccess extends DataSellerDetailSuccessProduct {
  SellerDetailProductSuccess({required super.state});
}
class SellerInfoDetailProductSuccess extends DataSellerDetailSuccessProduct {
  SellerInfoDetailProductSuccess({required super.state});
}
class DetailProductFailed extends DetailProductState {
  DetailProductFailed({required super.state});
}

