part of 'mercari_search_cubit.dart';

@immutable
abstract class MercariSearchState {
  MercariSearchState({required MercariSearchState? state}) {
    dtoPopular = state?.dtoPopular;
    dtoSuggest = state?.dtoSuggest;
    data = state?.data;
    rakutenResolverDto = state?.rakutenResolverDto;
    canLoadMore = state?.canLoadMore;
  }
  SearchPopularDto? dtoPopular;
  SearchSuggestionDto? dtoSuggest;
  MercariSearchKeyWordDto? data;
  RakutenResolverDto? rakutenResolverDto;
  bool? canLoadMore;
  void copy(MercariSearchState? state) {
    dtoPopular = state?.dtoPopular;
    dtoSuggest = state?.dtoSuggest;
    data = state?.data;
    rakutenResolverDto = state?.rakutenResolverDto;
    canLoadMore = state?.canLoadMore;
  }
}

class MercariSearchInitial extends MercariSearchState {
  MercariSearchInitial({required super.state});
}
class MercariSearchLoading extends MercariSearchState {
  MercariSearchLoading({required super.state});
}
class MercariSearchSuccess extends MercariSearchState {
  MercariSearchSuccess({required super.state});
}
class MercariItemKeySearchSuccess extends MercariSearchState {
  MercariItemKeySearchSuccess({required super.state});

}
class MercariSearchPopularSuccess extends MercariSearchState {
  MercariSearchPopularSuccess({required super.state});
}
class MercariSearchSuggestionSuccess extends MercariSearchState {
  MercariSearchSuggestionSuccess({required super.state});
}
class MercariSearchObjectResolverLoading extends MercariSearchState {
  MercariSearchObjectResolverLoading({required super.state});
}
class MercariSearchObjectResolverSuccess extends MercariSearchState {
  MercariSearchObjectResolverSuccess({required super.state});
}
class MercariSearchObjectResolverFailed extends MercariSearchState {
  MercariSearchObjectResolverFailed({required super.state});
}