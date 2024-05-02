import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/detail/detail_dto.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/list/relates_dto.dart';

import '../../../data/datasource/details_product/detail_product_datasource.dart';
import '../../../data/datasource/seller/seller_datasource.dart';
import '../../../data/object_request_api/dashboard/top_shop/top_shop_request.dart';
import '../../../data/remote/middle-handler/failure.dart';
import '../../../data/remote/middle-handler/result-handler.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';
import '../../dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import '../../dtos/detail_product/detail_marcari/detail_marcari_dto.dart';
import '../../dtos/detail_product/rakuten_detail/rakuten_detail_dto.dart';
import '../../dtos/detail_product/seller_auction/seller_auction_dto.dart';
import '../../dtos/detail_product/y_shopping/y_shopping_dto.dart';
import '../../dtos/seller/seller_mercari/seller_mercari_dto.dart';
import '../../dtos/user/warehouse/warehouse_dto.dart';

@Singleton()
class SellerDetailProductRepo {
  SellerDataSource get _dataSource => getIt<SellerDataSource>();


  //seller auction
  Future<Either<Failure, SellerDetailAuctionDto>> sellerAuction(String code) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.sellerAuction(code);
    });
  }
  Future<Either<Failure, SellerInfoAuctionDto>> sellerInfo(String code) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.sellerInfo(code);
    });
  }
  //seller mercari
  Future<Either<Failure, SellerDetailMercariDto>> sellerMercari(String code,String name) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.sellerMercari(code,name);
    });
  }
}
