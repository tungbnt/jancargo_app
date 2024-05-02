import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/domain/dtos/user/deleted_account/deleted_account_dto.dart';
import 'package:jancargo_app/src/domain/dtos/user/session/session_dto.dart';
import 'package:jancargo_app/src/domain/repositories/management/oder_management_repo.dart';
import 'package:jancargo_app/src/general/inject_dependencies/inject_dependencies.dart';
import 'package:meta/meta.dart';

import '../../../data/object_request_api/request_change/request_change_pass.dart';
import '../../../domain/repositories/setting/setting_repo.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial(state: null));
  final TextEditingController oldPass = TextEditingController();
  final TextEditingController newPass = TextEditingController();
  final TextEditingController newAgainPass = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final SettingRepo repo = SettingRepo();
  OderManagementRepo getOder = getIt<OderManagementRepo>();

  Future<void> changePass(String id) async {
    emit(SettingLoading(state: state));
    repo
        .changePass(
          request: ChangePassRequest(
              oldPassword: oldPass.text,
              newPassword: newPass.text,
              confirmNewPassword: newAgainPass.text,
              id: id),
        )
        .then(
          (value) => value.fold(
            (left) {
            return emit(SettingFailChangSuccess(state: state));
            },
            (right) async {
              if (right) {
                return emit(SettingSuccess(state: state));
              } else {
                return emit(SettingFailChangSuccess(state: state));
              }
            },
          ),
        );
  }

  void fetchSession() async {
    emit(SettingLoading(state: state));
    final response = await getOder.sessionUser();

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(SettingSuccess(state: state)..sessionDto = r);
    });
  }

  void deletedMyAccount() async {
    emit(SettingDeletedAccountLoading(state: state));
    final response = await getOder.deletedMyAccount();

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(SettingDeletedAccountSuccess(state: state)..deletedAccountDto = r);
    });
  }
}
