import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/inject_dependencies/inject_dependencies.dart';
import 'package:meta/meta.dart';

import '../../../../domain/dtos/detail_product/seller_auction/seller_auction_dto.dart';
import '../../../../domain/repositories/seller/seller_repo.dart';
import '../../../../general/constants/app_storage.dart';
import '../../../searchs/bloc/filter_search/filter_search_cubit.dart';
import '../../../searchs/widget/filter_radio_horizontal.dart';

part 'seller_auction_state.dart';
class AuctionFilterSellerModel {
  final FilterSearchCubit searchCubit = FilterSearchCubit();
  final FilterRadioHorizontalController conditionsFilterController = FilterRadioHorizontalController(
    AppStorage.auctionFilterConditions,
    selectedOption: AppStorage.auctionDefaultFilterCondition,
  );

  final FilterRadioHorizontalController conditionsStoreFilterController = FilterRadioHorizontalController(
    AppStorage.auctionFilterStoreConditions,
    selectedOption: AppStorage.auctionDefaultFilterStoreCondition,
  );

}
class SellerAuctionCubit extends Cubit<SellerAuctionState> {
  SellerAuctionCubit() : super(SellerDetailProductInitial(state: null));
  SellerDetailProductRepo get = getIt<SellerDetailProductRepo>();
  final AuctionFilterSellerModel filterModel = AuctionFilterSellerModel();
  final ValueNotifier<TextEditingController>? controller = ValueNotifier(TextEditingController());


  //auction
  Future<void> getSellerAuction(String code) async {
    Future.delayed(Duration(seconds: 1));
    emit(SellerDetailProductLoading(state: state));
    try {
      List<SellerAuctionState?> statusListLoadDataSuccess = await Future.wait<
          SellerAuctionState?>(
          [_fetchSellerAuction(code), _fetchSellerInfoAuction(code,),]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is SellerSuccessProduct &&
          statusListLoadDataSuccess[1] is SellerSuccessProduct
      ) {
        emit(statusListLoadDataSuccess[0]!
          ..copy(statusListLoadDataSuccess[1])
        );
        await Future.delayed(const Duration(seconds: 1));
      }
    }catch(e){
      print('${e} có lỗi xảy ra');
    }
  }
  Future<SellerAuctionState?> _fetchSellerAuction(String code) async {
    final response = await get.sellerAuction(code);
    SellerAuctionState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(SellerDetailProductSuccess(state: state)..sellerDetailAuctionDto = r);

      // state = SellerDetailProductSuccess(state: state)
      //   ..sellerDetailAuctionDto = r;
    });
    return state;
  }

  Future<SellerAuctionState?> _fetchSellerInfoAuction(String code) async {
    final response = await get.sellerInfo(code);
    SellerAuctionState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.avatar != null){
        emit(SellerInfoDetailProductSuccess(state: state)..sellerInfoAuctionDto = r);

        // state = SellerInfoDetailProductSuccess(state: state)
        //   ..sellerInfoAuctionDto = r;
      }

    });
    return state;
  }

  Future<void> fetchSellerAuction(String code) async {
    Future.delayed(Duration(seconds: 1));
    emit(SellerDetailProductLoading(state: state));
    final response = await get.sellerAuction(code);

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.data!.seller == null){
        return fetchSellerInfoAuction(code,r);
      }
      emit(SellerDetailProductSuccess(state: state)..sellerDetailAuctionDto = r);

    });

  }

  Future<void> fetchSellerInfoAuction(String code,SellerDetailAuctionDto? sellerDetailAuctionDto) async {
    final response = await get.sellerInfo(code);
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.id != null){
        emit(SellerDetailProductSuccess(state: state)..sellerDetailAuctionDto = sellerDetailAuctionDto..sellerInfoAuctionDto = r);

        // state = SellerInfoDetailProductSuccess(state: state)
        //   ..sellerInfoAuctionDto = r;
      }else{
        emit(SellerDetailProductSuccess(state: state)..sellerDetailAuctionDto = sellerDetailAuctionDto);
      }

    });

  }

}
