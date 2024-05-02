part of 'setting_cubit.dart';

@immutable
abstract class SettingState {
  SettingState({required SettingState? state}) {

    sessionDto = state?.sessionDto;
    deletedAccountDto = state?.deletedAccountDto;
  }

  SessionDto? sessionDto;
  DeletedAccountDto? deletedAccountDto;

  void copy(SettingState? state) {
    sessionDto = state?.sessionDto;
    deletedAccountDto = state?.deletedAccountDto;
  }
}

class SettingInitial extends SettingState {
  SettingInitial({required super.state});
}
class SettingLoading extends SettingState {
  SettingLoading({required super.state});
}
class SettingSuccess extends SettingState {
  SettingSuccess({required super.state});
}
class SettingFailChangSuccess extends SettingState {
  SettingFailChangSuccess({required super.state});
}
class SettingDeletedAccountLoading extends SettingState {
  SettingDeletedAccountLoading({required super.state});
}
class SettingDeletedAccountSuccess extends SettingState {
  SettingDeletedAccountSuccess({required super.state});
}
