import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/data/object_request_api/auction/price_auction/price_auction_request.dart';
import 'package:jancargo_app/src/domain/dtos/auction/price/price_dto.dart';
import 'package:jancargo_app/src/domain/dtos/cart/calculate_cart/calculate_cart_dto.dart';

import '../../../data/datasource/cart/cart_datasource.dart';
import '../../../data/object_request_api/add_cart/add_cart_request.dart';
import '../../../data/object_request_api/update_item_cart/update_item_cart_request.dart';
import '../../../data/remote/middle-handler/failure.dart';
import '../../../data/remote/middle-handler/result-handler.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';
import '../../dtos/cart/add_item_cart/add_item_cart_dto.dart';
import '../../dtos/cart/item_cart/item_cart_dto.dart';

@Singleton()
class CartRepo {
  CartDataSource get _dataSource => getIt<CartDataSource>();


  Future<Either<Failure, AddItemCartDto>> addCart(
      {required AddCartRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.addCart(request);
    });
  }

  Future<Either<Failure, CartDto>> itemCart() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.itemCart();
    });
  }
  Future<Either<Failure, bool>> removeItemCart(List<String> idItemCart) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.removeItemCart(idItemCart);
    });
  }

  Future<Either<Failure, bool>> updateItemCart({required UpdateItemCartRequest updateItemCartRequest}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.updateItemCart(updateItemCartRequest);
    });
  }

  Future<Either<Failure, CalculateCartDto>> getCalculatePrice(
      {required PriceCalculateCartRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.getCalculatePrice(request: request);
    });
  }
}
