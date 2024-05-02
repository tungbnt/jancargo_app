part of 'seller_mercari_cubit.dart';

@immutable
abstract class SellerMercariState {

  SellerMercariState({required SellerMercariState? state}) {

    sellerDetailMercariDto = state?.sellerDetailMercariDto;
  }


  SellerDetailMercariDto? sellerDetailMercariDto;

  void copy(SellerMercariState? state) {

    sellerDetailMercariDto = state?.sellerDetailMercariDto;
  }
}

class SellerDetailProductInitial extends SellerMercariState {
  SellerDetailProductInitial({required super.state});
}
class SellerDetailProductLoading extends SellerMercariState {
  SellerDetailProductLoading({required super.state});
}

class SellerSuccessProduct extends SellerMercariState {
  SellerSuccessProduct({required super.state});
}

