import 'package:bloc/bloc.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:meta/meta.dart';

import '../../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../../domain/dtos/search/search_popular/search_popular_dto.dart';
import '../../../../domain/dtos/site_model/paypay/paypay_dto.dart';
import '../../../../domain/repositories/dashboard/dashboard_repo.dart';
import '../../../../domain/repositories/search/search_repo.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'paypay_state.dart';

class PaypayCubit extends Cubit<PaypayState> {
  PaypayCubit() : super(PaypayInitial(state: null));

  DashBoardRepo get = getIt<DashBoardRepo>();
  SearchRepo getSearch = getIt<SearchRepo>();

  Future<void> prepare() async {
    emit(PaypayLoading(state: null));
    // goi api de lay goi y
    try {
      List<PaypayState?> list = await Future.wait(
          [_fetchPopular(), _fetchPay(),]);
      if (list.every((element) => element != null) &&
          list[0] is PaypayDataSuccess &&
          list[1] is PaypayDataSuccess
      ) {
        emit(list[0]!
          ..copy(list[1])
        );
      }
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print('${e} có lỗi xảy ra');
    }
  }

  //api list screen
  Future<PaypayState?> _fetchPopular() async {
    final response = await getSearch.searchPopular(request: SearchSellerRequest(size: AppConstants.sizeApi));
    PaypayState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(PaypaySearchPopularDataSuccess(state: state)
        ..searchPopularDto = r);
    });
    return state;
  }

  Future<PaypayState?> _fetchPay() async {
    final response = await get.searchPaypay();
    PaypayState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(PaypayItemSuccess(state: state)
        ..dto = r.data!);
    });
    return state;
  }


}
