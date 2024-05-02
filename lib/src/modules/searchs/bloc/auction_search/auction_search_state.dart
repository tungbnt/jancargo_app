part of 'auction_search_cubit.dart';

@immutable
abstract class AuctionSearchState {
  AuctionSearchState({required AuctionSearchState? state}) {
    dtoPopular = state?.dtoPopular;
    dtoSuggest = state?.dtoSuggest;
    data = state?.data;
    auctionSearchDto = state?.auctionSearchDto;
    rakutenResolverDto = state?.rakutenResolverDto;
    producerSearchDto = state?.producerSearchDto;
    canLoadMore = state?.canLoadMore;
  }

  SearchPopularDto? dtoPopular;
  SearchSuggestionDto? dtoSuggest;
  AuctionDto? data;
  AuctionSearchDto? auctionSearchDto;
  RakutenResolverDto? rakutenResolverDto;
  ProducerSearchDto? producerSearchDto;
  bool? canLoadMore;

  void copy(AuctionSearchState? state) {
    dtoPopular = state?.dtoPopular;
    dtoSuggest = state?.dtoSuggest;
    data = state?.data;
    auctionSearchDto = state?.auctionSearchDto;
    rakutenResolverDto = state?.rakutenResolverDto;
    producerSearchDto = state?.producerSearchDto;
    canLoadMore = state?.canLoadMore;
  }
}

class AuctionSearchInitial extends AuctionSearchState {
  AuctionSearchInitial({required super.state});
}

class AuctionSearchLoading extends AuctionSearchState {
  AuctionSearchLoading({required super.state});
}

class AuctionSearchSuccess extends AuctionSearchState {
  AuctionSearchSuccess({required super.state});
}
class AuctionItemKeySearchEmpty extends AuctionSearchState {
  AuctionItemKeySearchEmpty({required super.state});
}

class AuctionFailure extends AuctionSearchState {
  AuctionFailure({required super.state});
}


class AuctionItemKeySearchCategory extends AuctionSearchState {
  AuctionItemKeySearchCategory({required super.state});
}
class AuctionItemKeySearchSuccess extends AuctionSearchState {
  AuctionItemKeySearchSuccess({required super.state});
}
class AuctionSearchPopularSuccess extends AuctionSearchState {
  AuctionSearchPopularSuccess({required super.state});
}

class AuctionSearchSuggestionSuccess extends AuctionSearchState {
  AuctionSearchSuggestionSuccess({required super.state});
}
class AuctionSearchObjectResolverLoading extends AuctionSearchState {
  AuctionSearchObjectResolverLoading({required super.state});
}
class AuctionSearchObjectResolverSuccess extends AuctionSearchState {
  AuctionSearchObjectResolverSuccess({required super.state});
}
class AuctionSearchObjectResolverFailed extends AuctionSearchState {
  AuctionSearchObjectResolverFailed({required super.state});
}
class BrandAuctionSearchLoading extends AuctionSearchState {
  BrandAuctionSearchLoading({required super.state});
}
class BrandAuctionSearchSuccess extends AuctionSearchState {
  BrandAuctionSearchSuccess({required super.state});
}