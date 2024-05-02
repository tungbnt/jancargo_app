import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/domain/dtos/object_resolver/rakuten_resolver/rakuten_resolver_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/rakuten_search_key_word/rakuten_search_key_word_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';

import '../../../../data/object_request_api/key_word/search_key_word_request.dart';
import '../../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../../domain/dtos/search/search_popular/search_popular_dto.dart';
import '../../../../domain/dtos/search/search_suggestion/search_suggestion_dto.dart';
import '../../../../domain/repositories/search/search_repo.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';
import '../filter_search/filter_search_cubit.dart';

part 'rakuten_search_state.dart';

class RakutenFilterModel {
  final FilterSearchCubit searchCubit = FilterSearchCubit();

}

class RakutenSearchCubit extends Cubit<RakutenSearchState> {
  RakutenSearchCubit() : super(RakutenSearchInitial(state: null));
  SearchRepo get = getIt<SearchRepo>();
  final ValueNotifier<TextEditingController>? controller = ValueNotifier(TextEditingController());
  final RakutenFilterModel filterModel = RakutenFilterModel();
  late SearchKeyWordRequest requestKeyWord;

  //
  SearchPopularDto searchPopularDto = const SearchPopularDto();
  SearchSuggestionDto searchSuggestionDto = const SearchSuggestionDto();

  int page = 0;

  bool canLoadMore = true;

  Future<void> prepare() async {
    emit(RakutenSearchLoading(state: state));
    // goi api de lay goi y
    try {
      List<RakutenSearchState?> list = await Future.wait([
        _fetchSuggestion(),
        _fetchPopular(),
      ]);
      if (list.every((element) => element != null) &&
          list[0] is RakutenSearchSuccess &&
          list[1] is RakutenSearchSuccess) {
        emit(list[0]!..copy(list[1]));
      }
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print('${e} có lỗi xảy ra');
    }
  }

  //call api suggestion => suggestion && popular
  Future<RakutenSearchState?> _fetchSuggestion() async {
    final response = await get.searchSuggestion(
        request: SearchSellerRequest(typeCode: 'rakuten'));
    RakutenSearchState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      //save data
      searchSuggestionDto = r;
      emit(RakutenSearchSuggestionSuccess(state: state)..dtoSuggest = r);
    });
    return state;
  }

  Future<RakutenSearchState?> _fetchPopular() async {
    final response = await get.searchPopular(
        request: SearchSellerRequest(typeCode: 'rakuten', size: '20'));
    RakutenSearchState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      //save data
      searchPopularDto = r;
      emit(RakutenSearchPopularSuccess(state: state)..dtoPopular = r);
    });
    return state;
  }

  Future<void> loadMore(String? keySearch) async {
    if (!canLoadMore) return;

    page++;

    load(keySearch);
  }

  Future<void> load(String? keySearch) async {
    emit(RakutenSearchLoading(state: state));

    await get
        .searchRakutenKeyWord(
        request: RakutenSearchKeyWordRequest(
          keyword: keySearch,
          query: keySearch,
          size: AppConstants.sizeApi,
          page: '1',
          sort: "-affiliateRate",
          priceFrom: filterModel.searchCubit.priceFromCtrl.text.replaceAll(',', ''),
          priceTo: filterModel.searchCubit.priceToCtrl.text.replaceAll(',', ''),

        ))
        .fold((l) {
    emit(RakutenSearchFailed(state: state));
    }, (r) {
          if(r.results!.isEmpty || r.results == []){
            emit(RakutenItemKeySearchEmpty(state: state));
            return savedDataSuggestion();
          }
      emit(RakutenItemKeySearchSuccess(state: state)
        ..data = r
        ..canLoadMore = canLoadMore);
    });
  }

  Future<void> objectResolverRakuten(String url) async {
    emit(RakutenObjectResolverLoading(state: state));

    await get
        .objectResolverRakuten(url: url).fold((l) {
      emit(RakutenSearchFailed(state: state));
    }, (r) async {
      await  RouteService.pop();
      await  Future.delayed(Duration(milliseconds: 300),()async{
         await RouteService.routeGoOnePage(
              RakutenDetailProductScreen(
                code:
                '${r.result!.shopUrl}:${r.result!.productId}',
                source: AppConstants.rakutenSource,
              ),
            );
      });

         // await  Future.delayed(Duration(milliseconds: 300),(){
         //   return emit(RakutenObjectResolverSuccess(state: state)..rakutenResolverDto = r);
         // });

    });
  }

  void savedDataSuggestion(){
    emit(RakutenSearchSuggestionSuccess(state: state)..dtoSuggest = searchSuggestionDto);
    emit(RakutenSearchPopularSuccess(state: state)..dtoPopular = searchPopularDto);
  }
}
