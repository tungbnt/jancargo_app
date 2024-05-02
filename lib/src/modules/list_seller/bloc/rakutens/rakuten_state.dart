part of 'rakuten_cubit.dart';

@immutable
abstract class RakutenState {
  RakutenState({required RakutenState? state}) {
    searchRakutenDto = state?.searchRakutenDto;
  }
   SearchRakutenDto? searchRakutenDto;

  void copy(RakutenState? state) {
    searchRakutenDto = state?.searchRakutenDto;
  }
}

class RakutenInitial extends RakutenState {
  RakutenInitial({required super.state});
}
class RakutenLoading extends RakutenState {
  RakutenLoading({required super.state});
}
class RakutenDataSuccess extends RakutenState {
  RakutenDataSuccess({required super.state});
}
class RakutenFailed extends RakutenState {
  RakutenFailed({required super.state});
}