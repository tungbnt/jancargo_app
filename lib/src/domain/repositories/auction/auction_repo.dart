import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/domain/dtos/auction/price/price_dto.dart';

import '../../../data/datasource/auction/auction_datasource.dart';
import '../../../data/object_request_api/auction/auction_off/auction_off_request.dart';
import '../../../data/object_request_api/auction/price_auction/price_auction_request.dart';
import '../../../data/remote/middle-handler/failure.dart';
import '../../../data/remote/middle-handler/result-handler.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';
import '../../dtos/auction/category_home/category_home_dto.dart';
import '../../dtos/auction/category_product/category_product_dto.dart';
import '../../dtos/dashboard/quick/quick_dto.dart';
import '../../dtos/dashboard/top_shop/top_shop_dto.dart';
import '../../dtos/flash_sale/amazon_js/amazon_js_dto.dart';
import '../../dtos/search/search_popular/search_popular_dto.dart';
import '../../dtos/user/tran_dto/tran_dto.dart';

@Singleton()
class AuctionRepo {
  AuctionDataSource get _dataSource => getIt<AuctionDataSource>();

  Future<Either<Failure, PriceDto>> getAuctionPrice(
      {required PriceRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.getAuctionPrice(request: request);
    });
  }
  Future<Either<Failure, TranDto>> getTran() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.getTran();
    });
  }
  Future<Either<Failure, int>> getPriceAuction(String idPro) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.getPriceAuction(idPro);
    });
  }
  Future<Either<Failure, int>> getPriceAuctionNow(String idPro) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.getPriceAuctionNow(idPro);
    });
  }
  Future<Either<Failure, String>> auctionOff(AuctionOffRequest request) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.auctionOff(request);
    });
  }
  Future<Either<Failure, SearchPopularDto>> searchPopular() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.searchPopular();
    });
  }
  Future<Either<Failure, CategoryHomeDto>> categoryHome() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.categoryHome();
    });
  }
  Future<Either<Failure, AmazonJsFlashSaleDto>> amazonFlashSale() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.amazonFlashSale();
    });
  }
  Future<Either<Failure, CategoryDto>> auctionProducts() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.auctionProducts();
    });
  }

  Future<Either<Failure, bool>> activeVip(String code) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.activeVip(code);
    });
  }
}