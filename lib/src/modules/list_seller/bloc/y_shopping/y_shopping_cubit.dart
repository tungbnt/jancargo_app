import 'package:bloc/bloc.dart';
import 'package:jancargo_app/src/domain/dtos/cart/item_cart/item_cart_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_shop/search_shopping_dto.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../../domain/repositories/dashboard/dashboard_repo.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'y_shopping_state.dart';

class YShoppingCubit extends Cubit<YShoppingState> {
  YShoppingCubit() : super(YShoppingInitial(state: null));
  DashBoardRepo get = getIt<DashBoardRepo>();
  int get defaultInitialPageNumber => 0;
  late int _pageNumber = defaultInitialPageNumber;

  List<ItemsShoppingDto>? results = [];
  late CartDto cartDto;

  bool avoidSpam = false;
  bool hasMoreData = true;

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  Future<void> load() {
    Future.delayed(Duration(milliseconds: 300),(){
     return emit(YShoppingLoading(state: state));
    });
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
      final response = await get.searchYShopping(request: SearchSellerRequest(size: AppConstants.sizeApi,query: AppConstants.querySearch,page: pageNumber.toString()));
      response.fold((l) {
        hasMoreData = false;
      }, (r) async {
        if(r.results!.isEmpty){
          hasMoreData = false;
          return;
        }
          hasMoreData = true;
        List<ItemCartDto> carts = cartDto.data!;
        List<ItemsShoppingDto> yShoppings = r.results!;
        // check isCarded
        for (var cartItem in carts) {
          for (var yShoppingItem in yShoppings) {
            if (cartItem.code == yShoppingItem.code) {
              yShoppingItem.isItemSavedCart = true;

              break; // Nếu tìm thấy trùng, thoát vòng lặp nội
            }
          }
        }
          emit(YShoppingDataSuccess(state: state)
            ..dto = SearchShoppingDto(results: yShoppings));

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
      final response = await get.searchYShopping(request: SearchSellerRequest(size: AppConstants.sizeApi,query: AppConstants.querySearch,page: pageNumber.toString()));
      response.fold((l) {
        hasMoreData = false;
        refreshController.loadFailed();
      }, (r) async {
        if(r.results!.isEmpty && r.results == []){
          hasMoreData = false;
          refreshController.loadNoData();
        }else{
          hasMoreData = true;
          emit(YShoppingDataSuccess(state: state)
            ..dto = r);
        }
      });
      _pageNumber = pageNumber;
    }
    avoidSpam = false;
    refreshController.refreshCompleted();
  }
}

