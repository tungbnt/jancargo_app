import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../data/object_request_api/dashboard/top_shop/top_shop_request.dart';
import '../../../../domain/dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import '../../../../domain/repositories/dashboard/dashboard_repo.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'recently_vieweds_state.dart';

class RecentlyViewedsCubit extends Cubit<RecentlyViewedsState> {
  RecentlyViewedsCubit() : super(RecentlyViewedsInitial(state: null));
  DashBoardRepo get = getIt<DashBoardRepo>();
  int get defaultInitialPageNumber => 1;
  late int _pageNumber = defaultInitialPageNumber;

  bool avoidSpam = false;
  bool hasMoreData = true;

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  final TextEditingController? textSearch = TextEditingController();

  Future<void> load(String? search) {
    return loadMore(search);
  }

  Future<void> loadMore(String? search) async {
    if(!avoidSpam && hasMoreData) {
      avoidSpam = true;
      //chuyển qua trang tiế theo
      int pageNumber = _pageNumber;
      pageNumber ++;
      print('number ${pageNumber}');
      //call api
      final response = await get.recentlyViewed(request: LoadItemRequest(size: AppConstants.sizeApi,page: pageNumber.toString(),site: search));
      response.fold((l) {
        hasMoreData = false;
      }, (r) async {
        if(r.result!.isEmpty && r.result == []){
          hasMoreData = false;

        }else{
          hasMoreData = true;
          search == null ?
          emit(RecentlyViewedsSuccess(state: state)
            ..dto = r) : emit(RecentlyViewedsSearchSuccess(state: state)
        ..dto = r);
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
      final response = await get.recentlyViewed(request: LoadItemRequest(size: AppConstants.sizeApi,page: pageNumber.toString()));
      response.fold((l) {
        hasMoreData = false;
        refreshController.loadFailed();
      }, (r) async {
        if(r.result!.isEmpty && r.result == []){
          hasMoreData = false;
          refreshController.loadNoData();
        }else{
          hasMoreData = true;
          emit(RecentlyViewedsSuccess(state: state)
            ..dto = r);
        }
      });
      _pageNumber = pageNumber;
    }
    avoidSpam = false;
    refreshController.refreshCompleted();
  }
}
