part of 'seller_auction_cubit.dart';

@immutable
abstract class SellerAuctionState {
  SellerAuctionState({required SellerAuctionState? state}) {

  sellerDetailAuctionDto = state?.sellerDetailAuctionDto;
  sellerInfoAuctionDto = state?.sellerInfoAuctionDto;
}


SellerDetailAuctionDto? sellerDetailAuctionDto;
SellerInfoAuctionDto? sellerInfoAuctionDto;

void copy(SellerAuctionState? state) {

  sellerDetailAuctionDto = state?.sellerDetailAuctionDto;
  sellerInfoAuctionDto = state?.sellerInfoAuctionDto;
}
}

class SellerDetailProductInitial extends SellerAuctionState {
  SellerDetailProductInitial({required super.state});
}
class SellerDetailProductLoading extends SellerAuctionState {
  SellerDetailProductLoading({required super.state});
}

class SellerSuccessProduct extends SellerAuctionState {
  SellerSuccessProduct({required super.state});
}
class SellerDetailProductSuccess extends SellerSuccessProduct {
  SellerDetailProductSuccess({required super.state});
}
class SellerInfoDetailProductSuccess extends SellerSuccessProduct {
  SellerInfoDetailProductSuccess({required super.state});
}
