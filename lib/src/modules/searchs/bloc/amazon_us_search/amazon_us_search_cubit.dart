import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/domain/dtos/object_resolver/rakuten_resolver/rakuten_resolver_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/amazon_js_search_keyword/amazon_js_search_keyword_dto.dart';

import '../../../../data/object_request_api/key_word/search_key_word_request.dart';
import '../../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../../domain/dtos/search/search_popular/search_popular_dto.dart';
import '../../../../domain/dtos/search/search_suggestion/search_suggestion_dto.dart';
import '../../../../domain/repositories/search/search_repo.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'amazon_us_search_state.dart';

class AmazonUsSearchCubit extends Cubit<AmazonUsSearchState> {
  AmazonUsSearchCubit() : super(AmazonUsSearchInitial(state: null));
  SearchRepo get = getIt<SearchRepo>();
  final ValueNotifier<TextEditingController>? controller = ValueNotifier(TextEditingController());
  late SearchKeyWordRequest requestKeyWord;

  //
  SearchPopularDto searchPopularDto = const SearchPopularDto();
  SearchSuggestionDto searchSuggestionDto = const SearchSuggestionDto();

  int page = 0;

  bool canLoadMore = true;

  Future<void> prepare() async {
    emit(AmazonUsSearchLoading(state: state));
    // goi api de lay goi y
    try {
      List<AmazonUsSearchState?> list = await Future.wait([
        _fetchSuggestion(),
        _fetchPopular(),
      ]);
      if (list.every((element) => element != null) &&
          list[0] is AmazonUsSearchSuccess &&
          list[1] is AmazonUsSearchSuccess) {
        emit(list[0]!..copy(list[1]));
      }
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print('${e} có lỗi xảy ra');
    }
  }

  //call api suggestion => suggestion && popular
  Future<AmazonUsSearchState?> _fetchSuggestion() async {
    final response = await get.searchSuggestion(
        request: SearchSellerRequest(typeCode: 'rakuten'));
    AmazonUsSearchState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      //save data
      searchSuggestionDto = r;
      emit(AmazonUsSearchSuggestionSuccess(state: state)..dtoSuggest = r);
    });
    return state;
  }

  Future<AmazonUsSearchState?> _fetchPopular() async {
    final response = await get.searchPopular(
        request: SearchSellerRequest(typeCode: 'rakuten', size: '20'));
    AmazonUsSearchState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      //save data
      searchPopularDto = r;
      emit(AmazonUsSearchPopularSuccess(state: state)..dtoPopular = r);
    });
    return state;
  }

  Future<void> loadMore(String? keySearch) async {
    if (!canLoadMore) return;

    page++;

    load(keySearch);
  }

  Future<void> load(String? keySearch) async {
    emit(AmazonUsSearchLoading(state: state));

    await get
        .amazonUsSearchKeyWord(
        request: SearchKeyWordRequest(
          keyword: keySearch,
          query: keySearch,
        ))
        .fold((l) {
    emit(AmazonUsFailure(state: state));
    }, (r) {
      if(r.products!.isEmpty || r.products == []){
        emit(AmazonUsItemKeySearchEmpty(state: state));
        return savedDataSuggestion();
      }
      emit(AmazonUsItemKeySearchSuccess(state: state)
        ..data = r
        ..canLoadMore = canLoadMore);
    });
  }

  Future<void> objectResolverRakuten(String url) async {
    emit(AmazonUsSearchObjectResolverLoading(state: state));

    await get
        .objectResolverRakuten(url: url).fold((l) {
      emit(AmazonUsSearchObjectResolverFailed(state: state));
    }, (r) async {

      await  Future.delayed(Duration(milliseconds: 300),(){
        return emit(AmazonUsSearchObjectResolverSuccess(state: state)..rakutenResolverDto = r);
      });

    });
  }

  void savedDataSuggestion(){
    emit(AmazonUsSearchSuggestionSuccess(state: state)..dtoSuggest = searchSuggestionDto);
    emit(AmazonUsSearchPopularSuccess(state: state)..dtoPopular = searchPopularDto);
  }
}
