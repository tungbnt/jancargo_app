import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:jancargo_app/src/data/object_request_api/list_request/list_request.dart';
import 'package:jancargo_app/src/domain/dtos/user/voucher/voucher_dto.dart';
import 'package:jancargo_app/src/domain/repositories/components/user/user_repo.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/inject_dependencies/inject_dependencies.dart';
import 'package:meta/meta.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit() : super(CouponInitial(state: null)){
    getCoupon();
  }
  final UserRepo _repo = getIt<UserRepo>();
  final TextEditingController controller = TextEditingController();

  void getCoupon() async {
    emit(CouponLoading(state: state));
    final response = await _repo.getCoupon(request: ListRequest(size: AppConstants.sizeApi,page: '0',),);

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(CouponDataSuccess(state: state)..voucherDto = r);

    });

  }
  void searchCoupon(String? keyword) async {
    if(keyword == null && keyword == ''){

      return emit(SearchCouponEmpty(state: state));
    }
    emit(SearchCouponLoading(state: state));
    final response = await _repo.getCoupon(request: ListRequest(size: AppConstants.sizeApi,page: '0',search: keyword),);

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {

      emit(SearchCouponDataSuccess(state: state)..voucherDto = r);

    });

  }
}
