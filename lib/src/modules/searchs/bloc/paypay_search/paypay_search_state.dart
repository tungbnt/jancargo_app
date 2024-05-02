part of 'paypay_search_cubit.dart';

@immutable
abstract class PaypaySearchState {
  PaypaySearchState({required PaypaySearchState? state}) {
    canLoadMore = state?.canLoadMore;
    dtoPopular = state?.dtoPopular;
    dtoSuggest = state?.dtoSuggest;
    data = state?.data;
    rakutenResolverDto = state?.rakutenResolverDto;
  }

  bool? canLoadMore;
  SearchPopularDto? dtoPopular;
  SearchSuggestionDto? dtoSuggest;
  PaypaySearchKeyWordDto? data;
  RakutenResolverDto? rakutenResolverDto;

  void copy(PaypaySearchState? state) {
    canLoadMore = state?.canLoadMore;
    dtoSuggest = state?.dtoSuggest;
    dtoPopular = state?.dtoPopular;
    data = state?.data;
    rakutenResolverDto = state?.rakutenResolverDto;
  }
}

class PaypaySearchInitial extends PaypaySearchState {
  PaypaySearchInitial({required super.state});
}

class PaypaySearchLoading extends PaypaySearchState {
  PaypaySearchLoading({required super.state});
}

class PaypaySearchSuccess extends PaypaySearchState {
  PaypaySearchSuccess({required super.state});
}

class PaypayItemKeySearchSuccess extends PaypaySearchState {
  PaypayItemKeySearchSuccess({required super.state});
}

class PaypayItemKeySearchEmpty extends PaypaySearchState {
  PaypayItemKeySearchEmpty({required super.state});
}
class PaypayFailure extends PaypaySearchState {
  PaypayFailure({required super.state});
}
class PaypaySearchPopularSuccess extends PaypaySearchSuccess {
  PaypaySearchPopularSuccess({required super.state});
}

class PaypaySearchSuggestionSuccess extends PaypaySearchSuccess {
  PaypaySearchSuggestionSuccess({required super.state});
}
class PaypaySearchObjectResolverLoading extends PaypaySearchSuccess {
  PaypaySearchObjectResolverLoading({required super.state});
}
class PaypaySearchObjectResolverSuccess extends PaypaySearchSuccess {
  PaypaySearchObjectResolverSuccess({required super.state});
}
class PaypaySearchObjectResolverFailed extends PaypaySearchSuccess {
  PaypaySearchObjectResolverFailed({required super.state});
}
