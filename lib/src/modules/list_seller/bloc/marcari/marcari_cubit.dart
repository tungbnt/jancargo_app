import 'package:bloc/bloc.dart';
import 'package:jancargo_app/src/domain/dtos/cart/item_cart/item_cart_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_mercari/search_mercari_dto.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../domain/repositories/dashboard/dashboard_repo.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'marcari_state.dart';

class MarcariCubit extends Cubit<MarcariState> {
  MarcariCubit() : super(MarcariInitial(state: null));
  DashBoardRepo get = getIt<DashBoardRepo>();

  //
  late SearchMercariDto dto;
  int get defaultInitialPageNumber => 0;
  late int _pageNumber = defaultInitialPageNumber;

  bool avoidSpam = false;
  bool hasMoreData = true;

  late CartDto cartDto;



  Future<void> load() {
    Future.delayed(const Duration(milliseconds: 300),(){ emit(MarcariLoading(state: state),);});
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
      final response = await get.searchMercari();
      response.fold((l) {
        hasMoreData = false;
      }, (r) async {
        if(r.data!.isEmpty && r.data == []){
          hasMoreData = false;
           emit(MarcariEmptyData(state: state));
        }else{
          hasMoreData = true;
          List<ItemCartDto> carts = cartDto.data!;
          List<MercarisDto> mercaris = r.data!;
          // check isCarded
          for (var cartItem in carts) {
            for (var mercariItem in mercaris) {
              if (cartItem.code == mercariItem.code) {
                mercariItem.isItemSavedCart = true;
                break; // Nếu tìm thấy trùng, thoát vòng lặp nội
              }
            }
          }
          emit(MarcariDataSuccess(state: state)
            ..dto = r);
        }
      });
      _pageNumber = pageNumber;
    }
    avoidSpam = false;
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
      final response = await get.searchMercari();
      response.fold((l) {
        hasMoreData = false;
        // refreshController.loadFailed();
      }, (r) async {
        if(r.data!.isEmpty && r.data == []){
          hasMoreData = false;
          // refreshController.loadNoData();
        }else{
          hasMoreData = true;
          emit(MarcariDataSuccess(state: state)
            ..dto = r);
        }
      });
      _pageNumber = pageNumber;
    }
    avoidSpam = false;
    // refreshController.refreshCompleted();
  }
}
