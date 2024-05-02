part of 'auction_cubit.dart';

@immutable
abstract class AuctionState {
  AuctionState({AuctionState? state}){
    dto = state?.dto;
    tranDto = state?.tranDto;
    categoryHomeDto = state?.categoryHomeDto;
    categoryProductDto = state?.categoryProductDto;
    searchPopularDto = state?.searchPopularDto;
    priceAuction = state?.priceAuction;
    sessionDto = state?.sessionDto;
}
  int? priceAuction;
  PriceDto? dto;
  TranDto? tranDto;
  SessionDto? sessionDto;
  SearchPopularDto? searchPopularDto;
  CategoryHomeDto? categoryHomeDto;
  CategoryDto? categoryProductDto;
  void copy(AuctionState? state) {
    dto = state?.dto;
    tranDto = state?.tranDto;
    searchPopularDto = state?.searchPopularDto;
    categoryHomeDto = state?.categoryHomeDto;
    categoryProductDto = state?.categoryProductDto;
    priceAuction = state?.priceAuction;
    sessionDto = state?.sessionDto;
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
class AuctionDataListSuccess extends AuctionState {
  AuctionDataListSuccess({required super.state});

}
class AuctionPopularDataSuccess extends AuctionDataListSuccess {
  AuctionPopularDataSuccess({required super.state});
}
class AuctionCategoryDataSuccess extends AuctionDataListSuccess {
  AuctionCategoryDataSuccess({required super.state});

}
class AuctionCategoryProductDataSuccess extends AuctionDataListSuccess {
  AuctionCategoryProductDataSuccess({required super.state});

}
class GetPriceAuctionDataSuccess extends AuctionDataSuccess {
  GetPriceAuctionDataSuccess({required super.state});

}
class GetTranAuctionDataSuccess extends AuctionDataSuccess {
  GetTranAuctionDataSuccess({required super.state});

}
class GetPriceProductAuctionDataSuccess extends AuctionDataSuccess {
  GetPriceProductAuctionDataSuccess({required super.state});

}
class GetSessionAuctionDataSuccess extends AuctionDataSuccess {
  GetSessionAuctionDataSuccess({required super.state});
}
class ActiveVipProductLoading extends AuctionDataListSuccess {
  ActiveVipProductLoading({required super.state});

}
class GetSessionAfterVipAuctionDataSuccess extends AuctionDataSuccess {
  GetSessionAfterVipAuctionDataSuccess({required super.state});
}
class ActiveVipProductDataSuccess extends AuctionDataListSuccess {
  ActiveVipProductDataSuccess({required super.state});

}
class ActiveVipProductNoSuccess extends AuctionDataListSuccess {
  ActiveVipProductNoSuccess({required super.state});

}
class ActiveVipProductFailed extends AuctionDataListSuccess {
  ActiveVipProductFailed({required super.state});

}
class SetPriceAuctionSuccess extends AuctionState {
  SetPriceAuctionSuccess({required super.state});
}
class SetPriceAuctionNoteSuccess extends AuctionState {
  SetPriceAuctionNoteSuccess({required super.state});
}
class SetPriceFailedSuccess extends AuctionState {
  SetPriceFailedSuccess({required super.state});
}
class SetPriceAuctionLoading extends AuctionState {
  SetPriceAuctionLoading({required super.state});
}
class SessionAuctionLoading extends AuctionState {
  SessionAuctionLoading({required super.state});
}