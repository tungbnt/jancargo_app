part of 'amazon_us_search_cubit.dart';

@immutable
abstract class AmazonUsSearchState { AmazonUsSearchState({required AmazonUsSearchState? state}) {
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

void copy(AmazonUsSearchState? state) {
  canLoadMore = state?.canLoadMore;
  dtoSuggest = state?.dtoSuggest;
  dtoPopular = state?.dtoPopular;
  data = state?.data;
  rakutenResolverDto = state?.rakutenResolverDto;
}
}

class AmazonUsSearchInitial extends AmazonUsSearchState {
  AmazonUsSearchInitial({required super.state});
}

class AmazonUsSearchLoading extends AmazonUsSearchState {
  AmazonUsSearchLoading({required super.state});
}

class AmazonUsSearchSuccess extends AmazonUsSearchState {
  AmazonUsSearchSuccess({required super.state});
}

class AmazonUsItemKeySearchSuccess extends AmazonUsSearchState {
  AmazonUsItemKeySearchSuccess({required super.state});
}
class AmazonUsItemKeySearchEmpty extends AmazonUsSearchState {
  AmazonUsItemKeySearchEmpty({required super.state});
}
class AmazonUsFailure extends AmazonUsSearchState {
  AmazonUsFailure({required super.state});
}
class AmazonUsSearchPopularSuccess extends AmazonUsSearchSuccess {
  AmazonUsSearchPopularSuccess({required super.state});
}

class AmazonUsSearchSuggestionSuccess extends AmazonUsSearchSuccess {
  AmazonUsSearchSuggestionSuccess({required super.state});
}
class AmazonUsSearchObjectResolverLoading extends AmazonUsSearchSuccess {
  AmazonUsSearchObjectResolverLoading({required super.state});
}
class AmazonUsSearchObjectResolverSuccess extends AmazonUsSearchSuccess {
  AmazonUsSearchObjectResolverSuccess({required super.state});
}
class AmazonUsSearchObjectResolverFailed extends AmazonUsSearchSuccess {
  AmazonUsSearchObjectResolverFailed({required super.state});
}
