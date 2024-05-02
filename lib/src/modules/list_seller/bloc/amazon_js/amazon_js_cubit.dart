import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/object_request_api/dashboard/banner_slider/banner_slider_request.dart';
import '../../../../domain/dtos/dashboard/banner_slider/banner_slider_dto.dart';
import '../../../../domain/dtos/site_model/amazon_js/amazon_js_dto.dart';
import '../../../../domain/repositories/dashboard/dashboard_repo.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'amazon_js_state.dart';

class AmazonJsCubit extends Cubit<AmazonJsState> {
  AmazonJsCubit() : super(AmazonJsInitial(state: null));
  DashBoardRepo get = getIt<DashBoardRepo>();

  Future<void> initEvent() async {
    emit(AmazonJsLoading(state: state));
    try {
      List<AmazonJsState?> statusListLoadDataSuccess = await Future.wait<
          AmazonJsState?>([_fetchBannerSlider(),_fetchAmazon()]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is AmazonJsDataSuccess &&
          statusListLoadDataSuccess[1] is AmazonJsDataSuccess
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


  //get list banner home
  Future<AmazonJsState?> _fetchBannerSlider() async {
    final response = await get.bannerSlider(request: BannerSliderRequest(page: '1',size: AppConstants.sizeApi,typePage: 'amazon'));
    AmazonJsState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AmazonJsSliderDataSuccess(state: state)..sliderDto = r);
      // state = AmazonJsSliderDataSuccess(state: state)
      //   ..sliderDto = r;
    });
    return state;
  }

  Future<AmazonJsState?> _fetchAmazon() async {
    final response = await get.searchAmazonJs();
    AmazonJsState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AmazonJsItemsDataSuccess(state: state)..dto = r);
      // state = AmazonJsItemsDataSuccess(state: state)
      //   ..dto = r;
    });
    return state;
  }
}
