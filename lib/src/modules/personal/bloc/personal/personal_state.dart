part of 'personal_cubit.dart';

@immutable
abstract class PersonalState {
  PersonalState({required PersonalState? state}) {
    dtoManager = state?.dtoManager;
    sessionDto = state?.sessionDto;
  }

  ManagementDto? dtoManager;
  SessionDto? sessionDto;

  void copy(PersonalState? state) {
    dtoManager = state?.dtoManager;
    sessionDto = state?.sessionDto;
  }
}

class PersonalInitial extends PersonalState {
  PersonalInitial({required super.state});
}
class PersonalLoading extends PersonalState {
  PersonalLoading({required super.state});
}
class PersonalDataSuccess extends PersonalState {
  PersonalDataSuccess({required super.state});
}

class OderPersonalSuccess extends PersonalDataSuccess {
  OderPersonalSuccess({required super.state});
}

class SessionPersonalSuccess extends PersonalDataSuccess {
  SessionPersonalSuccess({required super.state});
}
