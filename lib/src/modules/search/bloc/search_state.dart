part of 'search_cubit.dart';

@immutable
abstract class SearchState {
  SearchState({required SearchState? state}) {
    searchShoppingDto = state?.searchShoppingDto;
    searchMercariDto = state?.searchMercariDto;
    searchRakutenDto = state?.searchRakutenDto;
  }
  SearchShoppingDto? searchShoppingDto;
  SearchMercariDto? searchMercariDto;
  SearchRakutenDto? searchRakutenDto;

  void copy(SearchState? state) {
    searchShoppingDto = state?.searchShoppingDto;
    searchMercariDto = state?.searchMercariDto;
    searchRakutenDto = state?.searchRakutenDto;
  }
}

class SearchInitial extends SearchState {
  SearchInitial({required super.state});
}
class SearchDataSuccess extends SearchState {
  SearchDataSuccess({required super.state});
}
