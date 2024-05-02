import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:jancargo_app/src/data/object_request_api/oder_management/oder_management_request.dart';
import 'package:jancargo_app/src/domain/repositories/management/oder_management_repo.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../domain/dtos/oder_management/oder_management_dto.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

part 'oder_management_state.dart';

class OderManagementCubit extends Cubit<OderManagementState> {
  OderManagementCubit() : super(OderManagementInitial(state: null));
  OderManagementRepo get = getIt<OderManagementRepo>();

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  OptionDto optionDto = const OptionDto();




  void oderAll() async {
    final currentDate = DateTime.now();
    final ninetyDaysAgo = currentDate.subtract(const Duration(days: 90));

    final formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
    final formattedNinetyDaysAgo = DateFormat('yyyy-MM-dd').format(ninetyDaysAgo);

    final response = await get.oderManagement(request: OderManagementRequest(size: int.parse(AppConstants.sizeApi),page: 1,from: formattedNinetyDaysAgo,to: formattedCurrentDate,));
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.data!.results!.isEmpty){
       return emit(OderManagementEmpty(state: state));
      }
      emit(OderManagementAllSuccess(state: state)..managementDto = r);
    });
  }
  void waitForPay() async {
    emit(OderManagementLoading(state: state));
    final currentDate = DateTime.now();
    final ninetyDaysAgo = currentDate.subtract(const Duration(days: 90));

    final formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
    final formattedNinetyDaysAgo = DateFormat('yyyy-MM-dd').format(ninetyDaysAgo);

    final response = await get.oderManagement(request: OderManagementRequest(size: int.parse(AppConstants.sizeApi),page: 1,from: formattedNinetyDaysAgo,to: formattedCurrentDate,step: 1));
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.data!.results!.isEmpty){
        return emit(OderManagementEmpty(state: state));
      }
      emit(OderManagementWaitForPaySuccess(state: state)..managementDto = r);
      optionDto = r.options!;
    });
  }
  void purchase() async {
    emit(OderManagementLoading(state: state));
    final currentDate = DateTime.now();
    final ninetyDaysAgo = currentDate.subtract(const Duration(days: 90));

    final formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
    final formattedNinetyDaysAgo = DateFormat('yyyy-MM-dd').format(ninetyDaysAgo);

    final response = await get.oderManagement(request: OderManagementRequest(size: int.parse(AppConstants.sizeApi),page: 1,from: formattedNinetyDaysAgo,to: formattedCurrentDate,step: 12.2));
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.data!.results!.isEmpty){
        return emit(OderManagementEmpty(state: state));
      }
      emit(OderManagementPurchaseSuccess(state: state)..managementDto = r);
    });
  }
  void transport() async {
    emit(OderManagementLoading(state: state));
    final currentDate = DateTime.now();
    final ninetyDaysAgo = currentDate.subtract(const Duration(days: 90));

    final formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
    final formattedNinetyDaysAgo = DateFormat('yyyy-MM-dd').format(ninetyDaysAgo);

    final response = await get.oderManagement(request: OderManagementRequest(size: int.parse(AppConstants.sizeApi),page: 1,from: formattedNinetyDaysAgo,to: formattedCurrentDate,step: 12.3));
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.data!.results!.isEmpty){
        return emit(OderManagementEmpty(state: state));
      }
      emit(OderManagementTransportSuccess(state: state)..managementDto = r);
    });
  }
  void processing() async {
    emit(OderManagementLoading(state: state));
    final currentDate = DateTime.now();
    final ninetyDaysAgo = currentDate.subtract(const Duration(days: 90));

    final formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
    final formattedNinetyDaysAgo = DateFormat('yyyy-MM-dd').format(ninetyDaysAgo);

    final response = await get.oderManagement(request: OderManagementRequest(size: int.parse(AppConstants.sizeApi),page: 1,from: formattedNinetyDaysAgo,to: formattedCurrentDate,step: 7));
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.data!.results!.isEmpty){
        return emit(OderManagementEmpty(state: state));
      }
      emit(OderManagementProcessingSuccess(state: state)..managementDto = r);
    });
  }
  void createdTicket() async {
    emit(OderManagementLoading(state: state));
    final currentDate = DateTime.now();
    final ninetyDaysAgo = currentDate.subtract(const Duration(days: 90));

    final formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
    final formattedNinetyDaysAgo = DateFormat('yyyy-MM-dd').format(ninetyDaysAgo);

    final response = await get.oderManagement(request: OderManagementRequest(size: int.parse(AppConstants.sizeApi),page: 1,from: formattedNinetyDaysAgo,to: formattedCurrentDate,step: 8));
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.data!.results!.isEmpty){
        return emit(OderManagementEmpty(state: state));
      }
      emit(OderManagementCreatedTicketSuccess(state: state)..managementDto = r);
    });
  }
  void delivering() async {
    emit(OderManagementLoading(state: state));
    final currentDate = DateTime.now();
    final ninetyDaysAgo = currentDate.subtract(const Duration(days: 90));

    final formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
    final formattedNinetyDaysAgo = DateFormat('yyyy-MM-dd').format(ninetyDaysAgo);

    final response = await get.oderManagement(request: OderManagementRequest(size: int.parse(AppConstants.sizeApi),page: 1,from: formattedNinetyDaysAgo,to: formattedCurrentDate,step: 9));
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.data!.results!.isEmpty){
        return emit(OderManagementEmpty(state: state));
      }
      emit(OderManagementDeliveringSuccess(state: state)..managementDto = r);
    });
  }
  void successDelivery() async {
    emit(OderManagementLoading(state: state));
    final currentDate = DateTime.now();
    final ninetyDaysAgo = currentDate.subtract(const Duration(days: 90));

    final formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
    final formattedNinetyDaysAgo = DateFormat('yyyy-MM-dd').format(ninetyDaysAgo);

    final response = await get.oderManagement(request: OderManagementRequest(size: int.parse(AppConstants.sizeApi),page: 1,from: formattedNinetyDaysAgo,to: formattedCurrentDate,step: 10));
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.data!.results!.isEmpty){
        return emit(OderManagementEmpty(state: state));
      }
      emit(OderManagementSuccessDelivery(state: state)..managementDto = r);
    });
  }
  void cancelled() async {
    emit(OderManagementLoading(state: state));
    final currentDate = DateTime.now();
    final ninetyDaysAgo = currentDate.subtract(const Duration(days: 90));

    final formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
    final formattedNinetyDaysAgo = DateFormat('yyyy-MM-dd').format(ninetyDaysAgo);

    final response = await get.oderManagement(request: OderManagementRequest(size: int.parse(AppConstants.sizeApi),page: 1,from: formattedNinetyDaysAgo,to: formattedCurrentDate,step: 11));
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.data!.results!.isEmpty){
        return emit(OderManagementEmpty(state: state));
      }
      emit(OderManagementCancelledSuccess(state: state)..managementDto = r);
    });
  }
}
