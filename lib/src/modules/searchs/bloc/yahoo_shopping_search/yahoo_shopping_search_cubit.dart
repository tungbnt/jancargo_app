import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:jancargo_app/src/domain/dtos/object_resolver/rakuten_resolver/rakuten_resolver_dto.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/filter_search/filter_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/widget/filter_default_radio.dart';

import '../../../../data/object_request_api/key_word/search_key_word_request.dart';
import '../../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../../domain/dtos/search/search_popular/search_popular_dto.dart';
import '../../../../domain/dtos/search/search_shop/search_shopping_dto.dart';
import '../../../../domain/dtos/search/search_suggestion/search_suggestion_dto.dart';
import '../../../../domain/repositories/search/search_repo.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'yahoo_shopping_search_state.dart';

class YahooShoppingFilterModel {
  final FilterSearchCubit searchCubit = FilterSearchCubit();

  final FilterDefaultRadioController conditionsFilterController = FilterDefaultRadioController(
    AppStorage.yahooShoppingFilterConditions,
    selectedOption: AppStorage.yahooShoppingDefaultFilterCondition,
  );
}

class YahooShoppingSearchCubit extends Cubit<YahooShoppingSearchState> {
  YahooShoppingSearchCubit() : super(YahooShoppingSearchInitial(state: null));
  SearchRepo get = getIt<SearchRepo>();
  final ValueNotifier<TextEditingController>? controller = ValueNotifier(TextEditingController());
  late SearchKeyWordRequest requestKeyWord;
  final YahooShoppingFilterModel filterModel = YahooShoppingFilterModel();

  //
  SearchPopularDto searchPopularDto = const SearchPopularDto();
  SearchSuggestionDto searchSuggestionDto = const SearchSuggestionDto();

  int page = 0;

  bool canLoadMore = true;

  Future<void> prepare() async {
    emit(YahooShoppingSearchLoading(state: state));
    // goi api de lay goi y
    try {
      List<YahooShoppingSearchState?> list = await Future.wait([
        _fetchSuggestion(),
        _fetchPopular(),
      ]);
      if (list.every((element) => element != null) &&
          list[0] is YahooShoppingSearchSuccess &&
          list[1] is YahooShoppingSearchSuccess) {
        emit(list[0]!..copy(list[1]));
      }
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print('${e} có lỗi xảy ra');
    }
  }

  //call api suggestion => suggestion && popular
  Future<YahooShoppingSearchState?> _fetchSuggestion() async {
    final response = await get.searchSuggestion(request: SearchSellerRequest(typeCode: 'rakuten'));
    YahooShoppingSearchState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      //save data
      searchSuggestionDto = r;
      emit(YahooShoppingSearchSuggestionSuccess(state: state)..dtoSuggest = r);
    });
    return state;
  }

  Future<YahooShoppingSearchState?> _fetchPopular() async {
    final response = await get.searchPopular(request: SearchSellerRequest(typeCode: 'rakuten', size: '20'));
    YahooShoppingSearchState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      //save data
      searchPopularDto = r;
      emit(YahooShoppingSearchPopularSuccess(state: state)..dtoPopular = r);
    });
    return state;
  }

  Future<void> loadMore(String? keySearch) async {
    if (!canLoadMore) return;

    page++;

    load(keySearch);
  }

  Future<void> load(String? keySearch) async {
    emit(YahooShoppingSearchLoading(state: state));

    final future = get.searchYShopping(
      request: YahooShoppingSearchKeyWordRequest(
        keyword: keySearch,
        query: keySearch,
        priceFrom: filterModel.searchCubit.priceFromCtrl.text.replaceAll(',', ''),
        priceTo: filterModel.searchCubit.priceToCtrl.text.replaceAll(',', ''),
        condition: filterModel.conditionsFilterController.groupValue.value?.remoteValue,
        sort: "-score",
        size: AppConstants.sizeApi,

      ),
    );

    await future.fold((l) {
      emit(YahooShoppingFailure(state: null));
    }, (r) {
      if (r.results!.isEmpty || r.results == []) {
        emit(YahooShoppingItemKeySearchEmpty(state: state));
        return savedDataSuggestion();
      } else {
        return emit(YahooShoppingItemKeySearchSuccess(state: state)
          ..data = r
          ..canLoadMore = canLoadMore);
      }
    });
  }

  Future<void> objectResolverRakuten(String url) async {
    emit(YahooShoppingSearchObjectResolverLoading(state: state));

    await get
        .objectResolverRakuten(url: url).fold((l) {
      emit(YahooShoppingSearchObjectResolverFailed(state: state));
    }, (r) async {

      await  Future.delayed(Duration(milliseconds: 300),(){
        return emit(YahooShoppingSearchObjectResolverSuccess(state: state)..rakutenResolverDto = r);
      });

    });
  }

  void savedDataSuggestion() {
    emit(YahooShoppingSearchSuggestionSuccess(state: state)..dtoSuggest = searchSuggestionDto);
    emit(YahooShoppingSearchPopularSuccess(state: state)..dtoPopular = searchPopularDto);
  }
}
