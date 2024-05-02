part of 'marcari_cubit.dart';

@immutable
abstract class MarcariState {
  MarcariState({required MarcariState? state}) {
    dto = state?.dto;
  }

  SearchMercariDto? dto;

  void copy(MarcariState? state) {
    dto = state?.dto;
  }
}

class MarcariInitial extends MarcariState {
  MarcariInitial({required super.state});
}
class MarcariLoading extends MarcariState {
  MarcariLoading({required super.state});
}

class MarcariDataSuccess extends MarcariState {
  MarcariDataSuccess({required super.state});
}
class MarcariEmptyData extends MarcariState {
  MarcariEmptyData({required super.state});
}

class MarcariFailed extends MarcariState {
  MarcariFailed({required super.state});
}
