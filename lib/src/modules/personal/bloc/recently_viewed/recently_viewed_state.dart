part of 'recently_viewed_cubit.dart';

@immutable
abstract class RecentlyViewedState { RecentlyViewedState({required RecentlyViewedState? state}) {
  recentlyDto = state?.recentlyDto;
}
RecentlyDto? recentlyDto;
void copy(RecentlyViewedState? state) {
  recentlyDto = state?.recentlyDto;
}
}

class RecentlyViewedInitial extends RecentlyViewedState {
  RecentlyViewedInitial({required super.state});
}
class RecentlyViewedLoading extends RecentlyViewedState {
  RecentlyViewedLoading({required super.state});
}

class RecentlyViewedSuccess extends RecentlyViewedState {
  RecentlyViewedSuccess({required super.state});
}
class RecentlyViewedEmpty extends RecentlyViewedState {
  RecentlyViewedEmpty({required super.state});
}
class RecentlyViewedSearchLoading extends RecentlyViewedState {
  RecentlyViewedSearchLoading({required super.state});
}
class RecentlyViewedSearchSuccess extends RecentlyViewedState {
  RecentlyViewedSearchSuccess({required super.state});
}

