import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/dtos/auction/category_home/category_home_dto.dart';
import '../../../domain/dtos/flash_sale/amazon_js/amazon_js_dto.dart';
import '../../../domain/repositories/auction/auction_repo.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

part 'flash_sale_state.dart';

class FlashSaleCubit extends Cubit<FlashSaleState> {
  FlashSaleCubit() : super(FlashSaleInitial(state: null));
  AuctionRepo getAuction = getIt<AuctionRepo>();

  Future<void> prepare() async {
    emit(FlashSaleLoading(state: state));
    // goi api de lay goi y
    try {
      List<FlashSaleState?> list = await Future.wait(
          [_fetchAmazonJs(),_fetchCategory(),]);
      if (list.every((element) => element != null) &&
          list[0] is FlashSaleDataSuccess &&
          list[1] is FlashSaleDataSuccess
      ) {
        emit(list[0]!
          ..copy(list[1])
        );
      }
      await Future.delayed(const Duration(seconds: 1));

    }catch(e){
      print('${e} có lỗi xảy ra');
    }
  }

  Future<FlashSaleState?> _fetchCategory() async {
    final response = await getAuction.categoryHome();
    FlashSaleState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(FlashSaleCategory(state: state)..categoryHomeDto = r);
    });
    return state;
  }

  Future<FlashSaleState?> _fetchAmazonJs() async {
    final response = await getAuction.amazonFlashSale();
    FlashSaleState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(FlashSaleAmazonJs(state: state)..amazonJsFlashSaleDto = r);
    });
    return state;
  }

  void fetchCategory() async {
    final response = await getAuction.categoryHome();

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(FlashSaleCategory(state: state)..categoryHomeDto = r);
    });

  }
}
