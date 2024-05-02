part of 'amazon_js_search_cubit.dart';

@immutable
abstract class AmazonJsSearchState { AmazonJsSearchState({required AmazonJsSearchState? state}) {
  canLoadMore = state?.canLoadMore;
  dtoPopular = state?.dtoPopular;
  dtoSuggest = state?.dtoSuggest;
  data = state?.data;
  rakutenResolverDto = state?.rakutenResolverDto;
}

bool? canLoadMore;
SearchPopularDto? dtoPopular;
SearchSuggestionDto? dtoSuggest;
AmazonSearchKeyWordDto? data;
RakutenResolverDto? rakutenResolverDto;


void copy(AmazonJsSearchState? state) {
  canLoadMore = state?.canLoadMore;
  dtoSuggest = state?.dtoSuggest;
  dtoPopular = state?.dtoPopular;
  data = state?.data;
  rakutenResolverDto = state?.rakutenResolverDto;
}
}

class AmazonJsSearchInitial extends AmazonJsSearchState {
  AmazonJsSearchInitial({required super.state});
}

class AmazonJsSearchLoading extends AmazonJsSearchState {
  AmazonJsSearchLoading({required super.state});
}

class AmazonJsSearchSuccess extends AmazonJsSearchState {
  AmazonJsSearchSuccess({required super.state});
}
class AmazonJsSearchFailure extends AmazonJsSearchState {
  AmazonJsSearchFailure({required super.state});
}
class AmazonJsItemKeySearchSuccess extends AmazonJsSearchState {
  AmazonJsItemKeySearchSuccess({required super.state});
}
class AmazonJsItemKeySearchEmpty extends AmazonJsSearchState {
  AmazonJsItemKeySearchEmpty({required super.state});
}

class AmazonJsSearchPopularSuccess extends AmazonJsSearchSuccess {
  AmazonJsSearchPopularSuccess({required super.state});
}

class AmazonJsSearchSuggestionSuccess extends AmazonJsSearchSuccess {
  AmazonJsSearchSuggestionSuccess({required super.state});
}
class AmazonJsSearchObjectResolverLoading extends AmazonJsSearchSuccess {
  AmazonJsSearchObjectResolverLoading({required super.state});
}
class AmazonJsSearchObjectResolverSuccess extends AmazonJsSearchSuccess {
  AmazonJsSearchObjectResolverSuccess({required super.state});
}
class AmazonJsSearchObjectResolverFailed extends AmazonJsSearchSuccess {
  AmazonJsSearchObjectResolverFailed({required super.state});
}