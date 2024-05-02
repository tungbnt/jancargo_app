import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/data/datasource/management/auction_manager/auction_manager_datasource.dart';
import 'package:jancargo_app/src/data/object_request_api/auction_manager/auction_manager_request.dart';
import 'package:jancargo_app/src/data/remote/middle-handler/failure.dart';
import 'package:jancargo_app/src/data/remote/middle-handler/result-handler.dart';
import 'package:jancargo_app/src/domain/dtos/auction_manager/auction_manager_dto.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/detail/detail_dto.dart';
import 'package:jancargo_app/src/general/inject_dependencies/inject_dependencies.dart';

@Singleton()
class AuctionManagementRepo {
  AuctionManagementSource get _dataSource => getIt<AuctionManagementSource>();

  Future<Either<Failure, AuctionManagerDto>> oderManagement(
      {required AuctionManagementRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.oderManagement(request: request);
    });
  }

  Future<Either<Failure, DetailDto>> updateItemAuction(
      {required String code}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.updateItemAuction(code);
    });
  }
}