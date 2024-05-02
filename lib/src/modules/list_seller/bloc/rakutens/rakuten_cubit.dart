import 'package:bloc/bloc.dart';
import 'package:jancargo_app/src/domain/dtos/cart/item_cart/item_cart_dto.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../../domain/dtos/search/search_rakuten/search_rakuten_dto.dart';
import '../../../../domain/repositories/dashboard/dashboard_repo.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'rakuten_state.dart';

class RakutenCubit extends Cubit<RakutenState> {
  RakutenCubit() : super(RakutenInitial(state: null));
  DashBoardRepo get = getIt<DashBoardRepo>();
  //
  late SearchRakutenDto dto;
  int get defaultInitialPageNumber => 1;
  late int _pageNumber = defaultInitialPageNumber;

  bool avoidSpam = false;
  bool hasMoreData = true;

  late CartDto cartDto;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  Future<void> load() {
   Future.delayed(Duration(milliseconds: 300),(){ emit(RakutenLoading(state: state),);});
    return loadMore();
  }

  Future<void> loadMore() async {
    if(!avoidSpam && hasMoreData) {
      avoidSpam = true;
      //chuyển qua trang tiế theo
      int pageNumber = _pageNumber;
      pageNumber ++;
      print('number ${pageNumber}');
      //call api
      final response = await get.searchRakuten(request: SearchSellerRequest(
          size: AppConstants.sizeApi,
          query: AppConstants.querySearchRakuten,
          page: pageNumber.toString()));
      response.fold((l) {
        hasMoreData = false;
      }, (r) async {
        if(r.data!.isEmpty && r.data == []){
          hasMoreData = false;

        }else{
          hasMoreData = true;
          List<ItemCartDto> carts = cartDto.data!;
          List<RakutensDto> rakutens = r.data!;
          // check isCarded
          for (var cartItem in carts) {
            for (var rakutenItem in rakutens) {
              if (cartItem.code == rakutenItem.code) {
                rakutenItem.isItemSavedCart = true;

                break; // Nếu tìm thấy trùng, thoát vòng lặp nội
              }
            }
          }
          emit(RakutenDataSuccess(state: state)
            ..searchRakutenDto = SearchRakutenDto(data: rakutens));
        }
      });
      _pageNumber = pageNumber;
    }
    avoidSpam = false;
    refreshController.loadComplete();
  }

  Future<void> refreshList() async {
    hasMoreData = true;
    _pageNumber = defaultInitialPageNumber;
    if(!avoidSpam && hasMoreData) {
      avoidSpam = true;
      //chuyển qua trang tiế theo
      int pageNumber = _pageNumber;
      pageNumber ++;
      //call api
      final response = await get.searchRakuten(request: SearchSellerRequest(
          size: AppConstants.sizeApi,
          query: AppConstants.querySearchRakuten,
          page: pageNumber.toString()));
      response.fold((l) {
        hasMoreData = false;
        refreshController.loadFailed();
      }, (r) async {
        if(r.data!.isEmpty && r.data == []){
          hasMoreData = false;
          refreshController.loadNoData();
        }else{
          hasMoreData = true;
          emit(RakutenDataSuccess(state: state)
            ..searchRakutenDto = r);
        }
      });
      _pageNumber = pageNumber;
    }
    avoidSpam = false;
    refreshController.refreshCompleted();
  }
}
