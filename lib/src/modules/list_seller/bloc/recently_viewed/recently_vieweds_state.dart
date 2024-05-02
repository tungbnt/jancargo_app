part of 'recently_vieweds_cubit.dart';

@immutable
abstract class RecentlyViewedsState {

  RecentlyViewedsState({required RecentlyViewedsState? state}) {
    dto = state?.dto;

  }
  RecentlyDto? dto;
  void copy(RecentlyViewedsState? state) {
    dto = state?.dto;
  }
}

class RecentlyViewedsInitial extends RecentlyViewedsState {
  RecentlyViewedsInitial({required super.state});
}
class RecentlyViewedsSuccess extends RecentlyViewedsState {
  RecentlyViewedsSuccess({required super.state});

}
class RecentlyViewedsSearchSuccess extends RecentlyViewedsState {
  RecentlyViewedsSearchSuccess({required super.state});

}
class RecentlyViewedsLoading extends RecentlyViewedsState {
  RecentlyViewedsLoading({required super.state});
}
