import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/domain/dtos/user/deleted_account/deleted_account_dto.dart';

import '../../../data/datasource/management/oder_management/oder_management_datasource.dart';
import '../../../data/object_request_api/oder_management/oder_management_request.dart';
import '../../../data/remote/middle-handler/failure.dart';
import '../../../data/remote/middle-handler/result-handler.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';
import '../../dtos/oder_management/oder_management_dto.dart';
import '../../dtos/user/bidding_user/bidding_user_dto.dart';
import '../../dtos/user/exchange_price/exchange_price_dto.dart';
import '../../dtos/user/session/session_dto.dart';

@Singleton()
class OderManagementRepo {
  OderManagementSource get _dataSource => getIt<OderManagementSource>();

  Future<Either<Failure, ManagementDto>> oderManagement({required OderManagementRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.oderManagement(request:request);
    });
  }

  //bidding
  Future<Either<Failure, BiddingDto>> userBidding() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.userBidding();
    });
  }

  //exchange_price
  Future<Either<Failure, ExchangeDto>> exchangePrice() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.exchangePrice();
    });
  }
  //session
  Future<Either<Failure, SessionDto>> sessionUser() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.sessionUser();
    });
  }
  Future<Either<Failure, DeletedAccountDto>> deletedMyAccount() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.deletedMyAccount();
    });
  }
}