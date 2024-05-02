import 'package:bloc/bloc.dart';
import 'package:jancargo_app/src/domain/repositories/management/oder_management_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/object_request_api/auction/auction_off/auction_off_request.dart';
import '../../../data/object_request_api/auction/price_auction/price_auction_request.dart';
import '../../../domain/dtos/auction/category_home/category_home_dto.dart';
import '../../../domain/dtos/auction/category_product/category_product_dto.dart';
import '../../../domain/dtos/auction/price/price_dto.dart';
import '../../../domain/dtos/search/search_popular/search_popular_dto.dart';
import '../../../domain/dtos/user/session/session_dto.dart';
import '../../../domain/dtos/user/tran_dto/tran_dto.dart';
import '../../../domain/repositories/auction/auction_repo.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

part 'auction_state.dart';

class AuctionListCubit extends Cubit<AuctionState> {
  AuctionListCubit() : super(AuctionInitial(state: null));
  AuctionRepo get = getIt<AuctionRepo>();
  OderManagementRepo getOder = getIt<OderManagementRepo>();

  Future<void> getAuction(PriceRequest request,String idPro,{bool now = false}) async {
    emit(AuctionLoading(state: state));

    try {
      List<AuctionState?> statusListLoadDataSuccess = await Future.wait<
          AuctionState?>(
          [_getSession(), _getTran(),_getAuctionPrice(request),_getPriceAuction(idPro,now),]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is AuctionDataSuccess &&
          statusListLoadDataSuccess[1] is AuctionDataSuccess &&
          statusListLoadDataSuccess[2] is AuctionDataSuccess &&
          statusListLoadDataSuccess[3] is AuctionDataSuccess
      ) {
        emit(statusListLoadDataSuccess[0]!
          ..copy(statusListLoadDataSuccess[1])
          ..copy(statusListLoadDataSuccess[2]
          )..copy(statusListLoadDataSuccess[3]
          )
        );
        await Future.delayed(const Duration(seconds: 2));
      }
    }catch(e){
      print('${e} có lỗi xảy ra');
    }
  }

  Future<void> getAuctionList() async {
    emit(AuctionLoading(state: state));

    try {
      List<AuctionState?> statusListLoadDataSuccess = await Future.wait<
          AuctionState?>(
          [ _fetchPopular(),_fetchCategory(),_fetchCategoryProduct()]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is AuctionDataListSuccess &&
          statusListLoadDataSuccess[1] is AuctionDataListSuccess &&
          statusListLoadDataSuccess[2] is AuctionDataListSuccess
      ) {
        emit(statusListLoadDataSuccess[0]!
          ..copy(statusListLoadDataSuccess[1])
          ..copy(statusListLoadDataSuccess[2])
        );
        await Future.delayed(const Duration(seconds: 1));
      }
    }catch(e){
      print('${e} có lỗi xảy ra');
    }
  }


  Future<AuctionState?> _getAuctionPrice(PriceRequest request) async {
    final response = await get.getAuctionPrice(request: request);
    AuctionState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(GetPriceAuctionDataSuccess(state: state)..dto = r);
      state = AuctionDataListSuccess(state: state)
        ..dto = r;
    });
    return state;
  }

  Future<AuctionState?> _getTran() async {

    final response = await get.getTran();
    AuctionState? state;
    response.fold((l) {
      // no action need analytics in future
      print('lỗi ví');
    }, (r) async {
      emit(GetTranAuctionDataSuccess(state: state)..tranDto = r);
      state = AuctionDataListSuccess(state: state)
        ..tranDto = r;
    });
    return state;
  }

  Future<AuctionState?> _getSession() async {

    final response = await getOder.sessionUser();
    AuctionState? state;
    response.fold((l) {
      // no action need analytics in future
      print('lỗi ví');
    }, (r) async {
      emit(GetSessionAuctionDataSuccess(state: state)..sessionDto = r);
      state = AuctionDataListSuccess(state: state)
        ..sessionDto = r;
    });
    return state;
  }

  Future<AuctionState?> _getPriceAuction(String idPro,bool now) async {

    final response = now ? await get.getPriceAuctionNow(idPro) : await get.getPriceAuction(idPro);
    AuctionState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(GetPriceProductAuctionDataSuccess(state: state)..priceAuction = r);
      state = AuctionDataListSuccess(state: state)
        ..priceAuction = r;
    });
    return state;
  }

  void auctionOff(AuctionOffRequest request) async {
    emit(SetPriceAuctionLoading(state: state));
    final response = await get.auctionOff(request);

    response.fold((l) {
      emit(SetPriceFailedSuccess(state: state));
    }, (r) async {
      if(r == 'Đặt giá thầu thành công'){
        emit(SetPriceAuctionSuccess(state: state));
      }else {
        emit(SetPriceAuctionNoteSuccess(state: state));
      }

    });
  }


  Future<AuctionState?> _fetchPopular() async {
    final response = await get.searchPopular();
    AuctionState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {

      emit(AuctionPopularDataSuccess(state: state)..searchPopularDto = r);
    });
    return state;
  }

  Future<AuctionState?> _fetchCategory() async {
    final response = await get.categoryHome();
    AuctionState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionCategoryDataSuccess(state: state)..categoryHomeDto = r);
    });
    return state;
  }

  Future<AuctionState?> _fetchCategoryProduct() async {
    final response = await get.auctionProducts();
    AuctionState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionCategoryProductDataSuccess(state: state)..categoryProductDto = r);
    });
    return state;
  }

  void activeVip(String code) async {
    emit(ActiveVipProductLoading(state: state));
   await  Future.delayed(Duration(milliseconds: 300));
    final response = await get.activeVip(code);

    response.fold((l) {
    emit(ActiveVipProductFailed(state: state));
    }, (r) async {
      if(r){
        emit(ActiveVipProductDataSuccess(state: state));
      }else{
        emit(ActiveVipProductNoSuccess(state: state));
      }

      session();
    });
  }
  void session() async {
    final response = await getOder.sessionUser();

    response.fold((l) {
      // no action need analytics in future
      print('lỗi ví');
    }, (r) async {
      emit(GetSessionAuctionDataSuccess(state: state)..sessionDto = r);
    });
  }
}
