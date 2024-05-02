import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/domain/dtos/object_resolver/rakuten_resolver/rakuten_resolver_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_mercari/search_mercari_dto.dart';
import 'package:meta/meta.dart';

import '../../../../data/object_request_api/key_word/search_key_word_request.dart';
import '../../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../../domain/dtos/search/mecari_search_key_word/mecari_search_key_word_dto.dart';
import '../../../../domain/dtos/search/search_popular/search_popular_dto.dart';
import '../../../../domain/dtos/search/search_suggestion/search_suggestion_dto.dart';
import '../../../../domain/repositories/search/search_repo.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'mercari_search_state.dart';

class MercariSearchCubit extends Cubit<MercariSearchState> {
  MercariSearchCubit() : super(MercariSearchInitial(state: null));
  SearchRepo get = getIt<SearchRepo>();
  late SearchKeyWordRequest requestKeyWord;

  final ValueNotifier<TextEditingController>? controller = ValueNotifier(TextEditingController());

  int page = 0;

  bool canLoadMore = true;

  Future<void> prepare() async {
    emit(MercariSearchLoading(state: state));
    // goi api de lay goi y
    try {
      List<MercariSearchState?> list = await Future.wait([
        _fetchSuggestion(),
        _fetchPopular(),
      ]);
      if (list.every((element) => element != null) &&
          list[0] is MercariSearchSuccess &&
          list[1] is MercariSearchSuccess) {
        emit(list[0]!..copy(list[1]));
      }
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print('${e} có lỗi xảy ra');
    }
  }

  //call api suggestion => suggestion && popular
  Future<MercariSearchState?> _fetchSuggestion() async {
    final response = await get.searchSuggestion(
        request: SearchSellerRequest(typeCode: 'mercari'));
    MercariSearchState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(MercariSearchSuggestionSuccess(state: state)..dtoSuggest = r);
    });
    return state;
  }

  Future<MercariSearchState?> _fetchPopular() async {
    final response = await get.searchPopular(
        request: SearchSellerRequest(typeCode: 'mercari', size: '20'));
    MercariSearchState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(MercariSearchPopularSuccess(state: state)..dtoPopular = r);
    });
    return state;
  }

  Future<void> loadMore(String? keySearch) async {
    if (!canLoadMore) return;

    page++;

    load(keySearch);
  }

  Future<void> load(String? keySearch) async {
    emit(MercariSearchLoading(state: state));

    await get
        .searchMercariKeyWord(
            request: SearchKeyWordRequest(
      keyword: keySearch,
    ))
        .fold((l) {}, (r) {
      emit(MercariItemKeySearchSuccess(state: state)
        ..data = r
        ..canLoadMore = canLoadMore);
    });
  }

  Future<void> objectResolverRakuten(String url) async {
    emit(MercariSearchObjectResolverLoading(state: state));

    await get
        .objectResolverRakuten(url: url).fold((l) {
      emit(MercariSearchObjectResolverFailed(state: state));
    }, (r) async {

      await  Future.delayed(Duration(milliseconds: 300),(){
        return emit(MercariSearchObjectResolverSuccess(state: state)..rakutenResolverDto = r);
      });

    });
  }
}
