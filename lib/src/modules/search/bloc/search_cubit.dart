import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../domain/dtos/search/search_mercari/search_mercari_dto.dart';
import '../../../domain/dtos/search/search_rakuten/search_rakuten_dto.dart';
import '../../../domain/dtos/search/search_shop/search_shopping_dto.dart';
import '../../../domain/repositories/search/search_repo.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial(state: null));
  SearchRepo get = getIt<SearchRepo>();

  //
  final TextEditingController textSearch = TextEditingController();

  //search seller Y shopping
  void fetchSearchYShopping(String textSearch) async {
    // final response = await get.searchYShopping(request: SearchSellerRequest(size: AppConstants.sizeApi,query: textSearch,page: '1'));

    // response.fold((l) {
    //   // no action need analytics in future
    // }, (r) async {
    //   emit(SearchDataSuccess(state: state)..searchShoppingDto = r);
    //
    //
    // });
  }
  //get list mercari
  void fetchSearchMercari() async {
    final response = await get.searchMercari();
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(SearchDataSuccess(state: state)..searchMercariDto = r);
    });

  }

  //get list rakuten
  void fetchSearchRakuten(String textSearch) async {
    final response = await get.searchRakuten(request: SearchSellerRequest(size: AppConstants.sizeApi,query: textSearch));

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(SearchDataSuccess(state: state)..searchRakutenDto = r);
    });

  }
}
