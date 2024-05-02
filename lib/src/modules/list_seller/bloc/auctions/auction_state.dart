part of 'auction_cubit.dart';

@immutable
abstract class AuctionState {
  AuctionState({required AuctionState? state}) {
    auctionDto = state?.auctionDto;
    searchPopularDto = state?.searchPopularDto;
    categoryHomeDto = state?.categoryHomeDto;
    categoryProductDto = state?.categoryProductDto;
  }
  AuctionDto? auctionDto;
  SearchPopularDto? searchPopularDto;
  CategoryHomeDto? categoryHomeDto;
  CategoryDto? categoryProductDto;

  void copy(AuctionState? state) {
    auctionDto = state?.auctionDto;
    searchPopularDto = state?.searchPopularDto;
    categoryHomeDto = state?.categoryHomeDto;
    categoryProductDto = state?.categoryProductDto;
  }
}

class AuctionInitial extends AuctionState {
  AuctionInitial({required super.state});
}
class AuctionLoading extends AuctionState {
  AuctionLoading({required super.state});
}

class AuctionDataSuccess extends AuctionState {
  AuctionDataSuccess({required super.state});
}
class AuctionListDataSuccess extends AuctionState {
  AuctionListDataSuccess({required super.state});
}
class AuctionSearchPopularDataSuccess extends AuctionListDataSuccess {
  AuctionSearchPopularDataSuccess({required super.state});
}
class AuctionCategoryDataSuccess extends AuctionListDataSuccess {
  AuctionCategoryDataSuccess({required super.state});
}
class AuctionCategoryProductDataSuccess extends AuctionListDataSuccess {
  AuctionCategoryProductDataSuccess({required super.state});
}
class AuctionProductDataSuccess extends AuctionListDataSuccess {
  AuctionProductDataSuccess({required super.state});
}
class AuctionFailed extends AuctionState {
  AuctionFailed({required super.state});
}