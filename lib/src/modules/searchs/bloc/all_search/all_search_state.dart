part of 'all_search_cubit.dart';

@immutable
abstract class AllSearchState {
  AllSearchState({required AllSearchState? state}) {
    data = state?.data;
    rakutenResolverDto = state?.rakutenResolverDto;
    currentTab = state?.currentTab;
  }

  SearchAllDto? data;
  RakutenResolverDto? rakutenResolverDto;
  int? currentTab;

  void copy(AllSearchState? state) {
    data = state?.data;
    rakutenResolverDto = state?.rakutenResolverDto;
    currentTab = state?.currentTab;
  }
}

class AllSearchInitial extends AllSearchState {
  AllSearchInitial({required super.state});
}

class AllSearchLoading extends AllSearchState {
  AllSearchLoading({required super.state});
}

class AllSearchSuccess extends AllSearchState {
  AllSearchSuccess({required super.state});
}

class AllSearchItemKeySearchSuccess extends AllSearchState {
  AllSearchItemKeySearchSuccess({required super.state});
}
class AllSearchObjectResolverLoading extends AllSearchState {
  AllSearchObjectResolverLoading({required super.state});
}
class AllSearchObjectResolverSuccess extends AllSearchState {
  AllSearchObjectResolverSuccess({required super.state});
}
class AllSearchObjectResolverFailed extends AllSearchState {
  AllSearchObjectResolverFailed({required super.state});
}
class AllSearchFailure extends AllSearchState {
  AllSearchFailure({required super.state});
}

class AllSearchItemKeySearchEmpty extends AllSearchState {
  AllSearchItemKeySearchEmpty({required super.state});
}
class AllSearchChangeTab extends AllSearchState {
  AllSearchChangeTab({required super.state});
}