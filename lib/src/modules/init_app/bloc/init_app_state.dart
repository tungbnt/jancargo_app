part of 'init_app_cubit.dart';

@immutable
abstract class InitAppState {
  InitAppState({required InitAppState? state}) {
    token = state?.token;
  }

  String? token;

  void copy(InitAppState? state) {
    token = state?.token;
  }
}

class InitAppInitial extends InitAppState {
  InitAppInitial({required super.state});
}

class InitOnBoarding extends InitAppState {
  InitOnBoarding({required super.state});
}

abstract class InitHomeDataState extends InitAppState {
  InitHomeDataState({required super.state});
}

class InitDataSuccess extends InitHomeDataState {
  InitDataSuccess({required super.state});
}
