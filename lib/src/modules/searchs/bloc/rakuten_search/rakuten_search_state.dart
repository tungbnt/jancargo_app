part of 'rakuten_search_cubit.dart';

@immutable
abstract class RakutenSearchState {
  RakutenSearchState({required RakutenSearchState? state}) {
    canLoadMore = state?.canLoadMore;
    dtoPopular = state?.dtoPopular;
    dtoSuggest = state?.dtoSuggest;
    data = state?.data;
    rakutenResolverDto = state?.rakutenResolverDto;
  }

  bool? canLoadMore;
  SearchPopularDto? dtoPopular;
  SearchSuggestionDto? dtoSuggest;
  RakutenSearchKeyWordDto? data;
  RakutenResolverDto? rakutenResolverDto;

  void copy(RakutenSearchState? state) {
    canLoadMore = state?.canLoadMore;
    dtoSuggest = state?.dtoSuggest;
    dtoPopular = state?.dtoPopular;
    data = state?.data;
    rakutenResolverDto = state?.rakutenResolverDto;
  }
}

class RakutenSearchInitial extends RakutenSearchState {
  RakutenSearchInitial({required super.state});
}

class RakutenSearchLoading extends RakutenSearchState {
  RakutenSearchLoading({required super.state});
}
class RakutenObjectResolverLoading extends RakutenSearchState {
  RakutenObjectResolverLoading({required super.state});
}
class RakutenSearchSuccess extends RakutenSearchState {
  RakutenSearchSuccess({required super.state});
}
class RakutenObjectResolverSuccess extends RakutenSearchState {
  RakutenObjectResolverSuccess({required super.state});
}
class RakutenItemKeySearchSuccess extends RakutenSearchState {
  RakutenItemKeySearchSuccess({required super.state});
}
class RakutenItemKeySearchEmpty extends RakutenSearchState {
  RakutenItemKeySearchEmpty({required super.state});
}
class RakutenSearchFailed extends RakutenSearchState {
  RakutenSearchFailed({required super.state});
}
class RakutenSearchPopularSuccess extends RakutenSearchSuccess {
  RakutenSearchPopularSuccess({required super.state});
}

class RakutenSearchSuggestionSuccess extends RakutenSearchSuccess {
  RakutenSearchSuggestionSuccess({required super.state});
}
