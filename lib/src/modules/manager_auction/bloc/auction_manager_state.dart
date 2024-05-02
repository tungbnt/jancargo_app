part of 'auction_manager_cubit.dart';

@immutable
abstract class AuctionManagerState {
  AuctionManagerState({required AuctionManagerState? state}) {
    auctionManagerDto = state?.auctionManagerDto;
    updateInfoAuction = state?.updateInfoAuction;
  }
  AuctionManagerDto? auctionManagerDto;
  DetailDto? updateInfoAuction;

  void copy(AuctionManagerState? state) {
    auctionManagerDto = state?.auctionManagerDto;
    updateInfoAuction = state?.updateInfoAuction;
  }
}

class AuctionManagerInitial extends AuctionManagerState {
  AuctionManagerInitial({required super.state});
}
class AuctionManagerLoading extends AuctionManagerState {
  AuctionManagerLoading({required super.state});
}
class AuctionManagerSuccess extends AuctionManagerState {
  AuctionManagerSuccess({required super.state});
}
class LoadingItemAuctionManagerSuccess extends AuctionManagerSuccess {
  LoadingItemAuctionManagerSuccess({required super.state});
}
class ReloadItemAuctionManagerSuccess extends AuctionManagerSuccess {
  ReloadItemAuctionManagerSuccess({required super.state});
}
