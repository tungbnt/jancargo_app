import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../data/object_request_api/dashboard/top_shop/top_shop_request.dart';
import '../../../../domain/dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import '../../../../domain/repositories/dashboard/dashboard_repo.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';
import '../../../searchs/bloc/filter_search/filter_search_cubit.dart';

part 'recently_viewed_state.dart';
class AuctionFilterModel {
  final FilterSearchCubit searchCubit = FilterSearchCubit();



}
class RecentlyViewedCubit extends Cubit<RecentlyViewedState> {
  RecentlyViewedCubit() : super(RecentlyViewedInitial(state: null));
  DashBoardRepo get = getIt<DashBoardRepo>();
  final TextEditingController textSearch = TextEditingController();
  final AuctionFilterModel filterModel = AuctionFilterModel();




  void getRecentlyViewed({String? searchKey = ""}) async {
    Future.delayed(Duration(milliseconds: 400),()=> emit(RecentlyViewedLoading(state: state)));
    final LoadItemRequest request = LoadItemRequest(size: '20',page: '1',search: searchKey);
    final response = await get.recentlyViewed(request: request);
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(RecentlyViewedSuccess(state: state)..recentlyDto = r);
      //gán data
    });
  }
}
