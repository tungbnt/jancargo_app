import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:jancargo_app/src/domain/repositories/management/oder_management_repo.dart';
import 'package:meta/meta.dart';

import '../../../../data/object_request_api/oder_management/oder_management_request.dart';
import '../../../../domain/dtos/oder_management/oder_management_dto.dart';
import '../../../../domain/dtos/user/session/session_dto.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'personal_state.dart';

class PersonalCubit extends Cubit<PersonalState> {
  PersonalCubit() : super(PersonalInitial(state: null));
  OderManagementRepo getOder = getIt<OderManagementRepo>();

  Future<void> initEvent() async {
  emit(PersonalLoading(state: state));
  await  Future.delayed(const Duration(milliseconds: 800),);
    try {
      List<PersonalState?> statusListLoadDataSuccess = await Future.wait<
          PersonalState?>([_fetchSession(),_fetchOderManager(),]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is PersonalDataSuccess &&
          statusListLoadDataSuccess[1] is PersonalDataSuccess
      ) {
        emit(statusListLoadDataSuccess[0]!
          ..copy(statusListLoadDataSuccess[1])
        );
        await Future.delayed(const Duration(seconds: 1));
      }
    }catch(e){
      print('${e} có lỗi xảy ra');
    }
  }

  //get list flash sale
  Future<PersonalState?> _fetchOderManager() async {
    final currentDate = DateTime.now();
    final ninetyDaysAgo = currentDate.subtract(const Duration(days: 90));

    final formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
    final formattedNinetyDaysAgo = DateFormat('yyyy-MM-dd').format(ninetyDaysAgo);
    final response = await getOder.oderManagement(request: OderManagementRequest(size: 20,page: 1,from: formattedNinetyDaysAgo,to: formattedCurrentDate));
    PersonalState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(OderPersonalSuccess(state: state)..dtoManager = r);
      state = PersonalDataSuccess(state: state)
        ..dtoManager = r;

    });
    return state;
  }

  Future<PersonalState?> _fetchSession() async {

    final response = await getOder.sessionUser();
    PersonalState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(SessionPersonalSuccess(state: state)..sessionDto = r);
      state = PersonalDataSuccess(state: state)
        ..sessionDto = r;

    });
    return state;
  }


}
