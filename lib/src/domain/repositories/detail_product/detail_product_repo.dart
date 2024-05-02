import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/detail/detail_dto.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/list/relates_dto.dart';

import '../../../data/datasource/details_product/detail_product_datasource.dart';
import '../../../data/object_request_api/dashboard/top_shop/top_shop_request.dart';
import '../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../data/remote/middle-handler/failure.dart';
import '../../../data/remote/middle-handler/result-handler.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';
import '../../dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import '../../dtos/detail_product/detail_marcari/detail_marcari_dto.dart';
import '../../dtos/detail_product/rakuten_detail/rakuten_detail_dto.dart';
import '../../dtos/detail_product/seller_auction/seller_auction_dto.dart';
import '../../dtos/detail_product/suggestion_rakuten/suggestion_rakuten_dto.dart';
import '../../dtos/detail_product/y_shopping/y_shopping_dto.dart';
import '../../dtos/favorite/favorite_dto.dart';
import '../../dtos/search/search_shop/search_shopping_dto.dart';
import '../../dtos/user/warehouse/warehouse_dto.dart';

@Singleton()
class DetailProductRepo {
  DetailProductSource get _dataSource => getIt<DetailProductSource>();

  Future<Either<Failure, DetailDto>> infoProduct(String code) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.infoProduct(code);
    });
  }

  Future<Either<Failure, RakutenDetailDto>> infoProductRakuten(String code) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.infoProductRakuten(code);
    });
  }
  Future<Either<Failure, YShoppingDetailDto>> infoProductYShopping(String code) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.infoProductYShopping(code);
    });
  }
  Future<Either<Failure, MarcariDetailDto>> infoProductMarcari(String code) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.infoProductMarcari(code);
    });
  }

  Future<Either<Failure, RecentlyDto>> recentlyViewed(
      {required LoadItemRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.recentlyViewed(request: request);
    });
  }

  Future<Either<Failure, RelateDto>> relates(String code) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.relates(code);
    });
  }

  Future<Either<Failure, WareHouseDto>> warehouse() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.warehouse();
    });
  }
  //seller
  Future<Either<Failure, SellerDetailAuctionDto>> sellerAuction() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.sellerAuction();
    });
  }
  Future<Either<Failure, SellerInfoAuctionDto>> sellerInfo(String code) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.sellerInfo(code);
    });
  }
  Future<Either<Failure, FavoriteSearchDto>> favorites() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.favorites();
    });
  }

  //search seller
  Future<Either<Failure, SearchShoppingDto>> suggestionsYShopping(
      {required SuggestionRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.suggestionsYShopping(request: request);
    });
  }

  Future<Either<Failure, RecentlyDto>> recentlyViewedYShopping(
      {required LoadItemRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.recentlyViewedYShopping(request: request);
    });
  }

  Future<Either<Failure, SuggestionRakutenDto>> suggestionsRakuten() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.suggestionsRakuten();
    });
  }
}
