import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/banner_slider/banner_slider_dto.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/quick/quick_dto.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/top_categories/top_categories_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_mercari/search_mercari_dto.dart';

import '../../../data/datasource/dashboard/home_data_source.dart';
import '../../../data/datasource/search/search_auction_datasource.dart';
import '../../../data/object_request_api/dashboard/auction/auction_request.dart';
import '../../../data/object_request_api/dashboard/banner_slider/banner_slider_request.dart';
import '../../../data/object_request_api/dashboard/quick/quick_request.dart';
import '../../../data/object_request_api/dashboard/top_shop/top_shop_request.dart';
import '../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../data/remote/middle-handler/failure.dart';
import '../../../data/remote/middle-handler/result-handler.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';
import '../../dtos/dashboard/auction/auction_dto.dart';
import '../../dtos/dashboard/flash_sale/flash_sale_dto.dart';
import '../../dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import '../../dtos/dashboard/top_shop/top_shop_dto.dart';
import '../../dtos/search/search_rakuten/search_rakuten_dto.dart';
import '../../dtos/search/search_shop/search_shopping_dto.dart';
import '../../dtos/site_model/amazon_js/amazon_js_dto.dart';
import '../../dtos/site_model/paypay/paypay_dto.dart';


@Singleton()
class DashBoardRepo {
  HomeSource get _dataSource => getIt<HomeSource>();
  SearchDatasource get _searchSource => getIt<SearchDatasource>();

  Future<Either<Failure, TopShopDto>> topShop(
      {required LoadItemRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.topShop(request: request);
    });
  }
  Future<Either<Failure, FlashSaleDto>> flashSale() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.flashSale();
    });
  }
  Future<Either<Failure, TopCategoriesDto>> topCategories(
      {required LoadItemRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.topCategories(request: request);
    });
  }
  Future<Either<Failure, RecentlyDto>> recentlyViewed(
      {required LoadItemRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.recentlyViewed(request: request);
    });
  }
  Future<Either<Failure, BannerSliderDto>> bannerSlider(
      {required BannerSliderRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.bannerSlider(request: request);
    });
  }
  Future<Either<Failure, QuickDto>> quick(
      {required QuickRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.quick(request: request);
    });
  }
  Future<Either<Failure, AuctionDto>> auction(
      {required AuctionRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.auction(request: request);
    });
  }

  //search seller
  Future<Either<Failure, SearchShoppingDto>> searchYShopping(
      {required SearchSellerRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.searchYShopping(request: request);
    });
  }
  Future<Either<Failure, SearchMercariDto>> searchMercari() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.searchMercari();
    });
  }
  Future<Either<Failure, SearchRakutenDto>> searchRakuten(
      {required SearchSellerRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.searchRakuten(request: request);
    });
  }
  Future<Either<Failure, PaypayDto>> searchPaypay(
     ) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.searchPaypay();
    });
  }
  Future<Either<Failure, AmazonJsDto>> searchAmazonJs(
      ) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.searchAmazonJs();
    });
  }
}
