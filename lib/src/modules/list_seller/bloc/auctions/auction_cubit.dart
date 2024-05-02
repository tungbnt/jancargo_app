import 'package:bloc/bloc.dart';
import 'package:jancargo_app/src/domain/dtos/auction/category_product/category_product_dto.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/auction/auction_dto.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../data/object_request_api/dashboard/auction/auction_request.dart';
import '../../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../../domain/dtos/auction/category_home/category_home_dto.dart';
import '../../../../domain/dtos/dashboard/quick/quick_dto.dart';
import '../../../../domain/dtos/search/search_popular/search_popular_dto.dart';
import '../../../../domain/repositories/auction/auction_repo.dart';
import '../../../../domain/repositories/dashboard/dashboard_repo.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'auction_state.dart';

class AuctionCubit extends Cubit<AuctionState> {
  AuctionCubit() : super(AuctionInitial(state: null));
  DashBoardRepo get = getIt<DashBoardRepo>();
  AuctionRepo getAuction = getIt<AuctionRepo>();
  int get defaultInitialPageNumber => 1;
  late int _pageNumber = defaultInitialPageNumber;

  bool avoidSpam = false;
  bool hasMoreData = true;

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  Future<void> load() {
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
      final response = await get.auction(request: AuctionRequest(size: AppConstants.sizeApi,category: '23260',page: pageNumber.toString()));
      response.fold((l) {
        hasMoreData = false;
      }, (r) async {
        if(r.results!.isEmpty && r.results == []){
          hasMoreData = false;

        }else{
          hasMoreData = true;
          emit(AuctionDataSuccess(state: state)
            ..auctionDto = r);
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
      final response = await get.auction(request: AuctionRequest(size: AppConstants.sizeApi,category: '23260',page: pageNumber.toString()));
      response.fold((l) {
        hasMoreData = false;
        refreshController.loadFailed();
      }, (r) async {
        if(r.results!.isEmpty && r.results == []){
          hasMoreData = false;
          refreshController.loadNoData();
        }else{
          hasMoreData = true;
          emit(AuctionDataSuccess(state: state)
            ..auctionDto = r);
        }
      });
      _pageNumber = pageNumber;
    }
    avoidSpam = false;
    refreshController.refreshCompleted();
  }

  Future<void> prepare() async {
    emit(AuctionLoading(state: null));
    // goi api de lay goi y
    try {
      List<AuctionState?> list = await Future.wait(
          [_fetchPopular(),_fetchAuctionProduct(),_fetchCategory(),_fetchCategoryProduct()]);
      if (list.every((element) => element != null) &&
          list[0] is AuctionListDataSuccess &&
          list[1] is AuctionListDataSuccess &&
          list[2] is AuctionListDataSuccess &&
          list[3] is AuctionListDataSuccess
      ) {
        emit(list[0]!
          ..copy(list[1])
          ..copy(list[2])
          ..copy(list[3])
        );
      }
      await Future.delayed(const Duration(seconds: 1));

    }catch(e){
      print('${e} có lỗi xảy ra');
    }
  }

  //api list screen
  Future<AuctionState?> _fetchPopular() async {
    final response = await getAuction.searchPopular();
    AuctionState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
     emit(AuctionSearchPopularDataSuccess(state: state)..searchPopularDto = r);
    });
    return state;
  }
  Future<AuctionState?> _fetchCategory() async {
    final response = await getAuction.categoryHome();
    AuctionState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
     emit(AuctionCategoryDataSuccess(state: state)..categoryHomeDto = r);
    });
    return state;
  }
  Future<AuctionState?> _fetchCategoryProduct() async {
    final response = await getAuction.auctionProducts();
    AuctionListDataSuccess? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionCategoryProductDataSuccess(state: state)..categoryProductDto = r);
    });
    return state;
  }
  Future<AuctionState?> _fetchAuctionProduct() async {
    final response = await get.auction(request: AuctionRequest(size: AppConstants.sizeApi,category: '23260',page: '1'));
    AuctionListDataSuccess? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionProductDataSuccess(state: state)..auctionDto = r);
    });
    return state;
  }
}

