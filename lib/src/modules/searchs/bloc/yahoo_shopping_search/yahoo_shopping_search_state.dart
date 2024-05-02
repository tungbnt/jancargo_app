part of 'yahoo_shopping_search_cubit.dart';

@immutable
abstract class YahooShoppingSearchState {
  YahooShoppingSearchState({required YahooShoppingSearchState? state}) {
    canLoadMore = state?.canLoadMore;
    dtoPopular = state?.dtoPopular;
    dtoSuggest = state?.dtoSuggest;
    data = state?.data;
    rakutenResolverDto = state?.rakutenResolverDto;
  }

  bool? canLoadMore;
  SearchPopularDto? dtoPopular;
  SearchSuggestionDto? dtoSuggest;
  SearchShoppingDto? data;
  RakutenResolverDto? rakutenResolverDto;


  void copy(YahooShoppingSearchState? state) {
    canLoadMore = state?.canLoadMore;
    dtoSuggest = state?.dtoSuggest;
    dtoPopular = state?.dtoPopular;
    data = state?.data;
    rakutenResolverDto = state?.rakutenResolverDto;
  }
}

class YahooShoppingSearchInitial extends YahooShoppingSearchState {
  YahooShoppingSearchInitial({required super.state});
}

class YahooShoppingSearchLoading extends YahooShoppingSearchState {
  YahooShoppingSearchLoading({required super.state});
}

class YahooShoppingSearchSuccess extends YahooShoppingSearchState {
  YahooShoppingSearchSuccess({required super.state});
}

class YahooShoppingItemKeySearchSuccess extends YahooShoppingSearchState {
  YahooShoppingItemKeySearchSuccess({required super.state});
}
class YahooShoppingFailure extends YahooShoppingSearchState {
  YahooShoppingFailure({required super.state});
}

class YahooShoppingItemKeySearchEmpty extends YahooShoppingSearchState {
  YahooShoppingItemKeySearchEmpty({required super.state});
}

class YahooShoppingSearchPopularSuccess extends YahooShoppingSearchSuccess {
  YahooShoppingSearchPopularSuccess({required super.state});
}

class YahooShoppingSearchSuggestionSuccess extends YahooShoppingSearchSuccess {
  YahooShoppingSearchSuggestionSuccess({required super.state});
}

class YahooShoppingSearchObjectResolverLoading extends YahooShoppingSearchSuccess {
  YahooShoppingSearchObjectResolverLoading({required super.state});
}
class YahooShoppingSearchObjectResolverSuccess extends YahooShoppingSearchSuccess {
  YahooShoppingSearchObjectResolverSuccess({required super.state});
}
class YahooShoppingSearchObjectResolverFailed extends YahooShoppingSearchSuccess {
  YahooShoppingSearchObjectResolverFailed({required super.state});
}
