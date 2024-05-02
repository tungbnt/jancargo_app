part of 'flash_sale_cubit.dart';

@immutable
abstract class FlashSaleState {

  FlashSaleState({required FlashSaleState? state}) {

    categoryHomeDto = state?.categoryHomeDto;
    amazonJsFlashSaleDto = state?.amazonJsFlashSaleDto;
  }

  CategoryHomeDto? categoryHomeDto;
  AmazonJsFlashSaleDto? amazonJsFlashSaleDto;


  void copy(FlashSaleState? state) {

    categoryHomeDto = state?.categoryHomeDto;
    amazonJsFlashSaleDto = state?.amazonJsFlashSaleDto;
  }
}

class FlashSaleInitial extends FlashSaleState {
  FlashSaleInitial({required super.state});
}
class FlashSaleLoading extends FlashSaleState {
  FlashSaleLoading({required super.state});
}
class FlashSaleDataSuccess extends FlashSaleState {
  FlashSaleDataSuccess({required super.state});
}
class FlashSaleAmazonJs extends FlashSaleDataSuccess {
  FlashSaleAmazonJs({required super.state});
}
class FlashSaleCategory extends FlashSaleDataSuccess {
  FlashSaleCategory({required super.state});
}
