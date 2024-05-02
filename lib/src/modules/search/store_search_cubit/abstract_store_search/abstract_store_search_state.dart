part of 'abstract_store_search_cubit.dart';

@immutable
class StoreSearchState<T> extends Equatable {
  const StoreSearchState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class StoreSearchLoading<T> extends StoreSearchState<T> {
  const StoreSearchLoading();
}

class StoreSearchSuggestion<T> extends StoreSearchState<T> {
  StoreSearchSuggestion({required StoreSearchSuggestion<T>? state}) {
    dto = state?.dto;
    dtoSuggest = state?.dtoSuggest;
  }
   SearchPopularDto? dto;
   SearchSuggestionDto? dtoSuggest;
  void copy(StoreSearchSuggestion<T>? state) {
    dto = state?.dto;
    dtoSuggest = state?.dtoSuggest;
  }
}

class SearchSuggestions<T> extends StoreSearchSuggestion<T> {
   SearchSuggestions({required super.state});



}
class SearchPopular<T> extends StoreSearchSuggestion<T> {
  SearchPopular({required super.state});
}

class StoreSearchSuccess<T> extends StoreSearchState<T> {
  const StoreSearchSuccess({
    required this.data,
    required this.canLoadMore,
  });

  final T data;
  final bool canLoadMore;
}

class StoreSearchFailed<T> extends StoreSearchState<T> {
  const StoreSearchFailed();
}
