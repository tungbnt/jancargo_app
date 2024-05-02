import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/data/object_request_api/list_request/list_request.dart';
import 'package:jancargo_app/src/domain/dtos/seller/favorite_seller/favorite_seller_dto.dart';
import 'package:jancargo_app/src/domain/dtos/user/location_user/location_user_dto.dart';
import 'package:jancargo_app/src/domain/dtos/user/voucher/voucher_dto.dart';

import '../../../../data/datasource/components/user/user_datasource.dart';
import '../../../../data/datasource/favorite/favorite_datasource.dart';
import '../../../../data/object_request_api/favorite/favorite_request.dart';
import '../../../../data/object_request_api/favorite_seller/favorite_seller_request.dart';
import '../../../../data/object_request_api/payment_oder/payment_oder_request.dart';
import '../../../../data/remote/middle-handler/failure.dart';
import '../../../../data/remote/middle-handler/result-handler.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';
import '../../../dtos/favorite/favorite_dto.dart';
import '../../../dtos/user/address_user/address_user_dto.dart';
import '../../../dtos/user/service_extras/service_extras_dto.dart';

@Singleton()
class UserRepo {
  FavoriteSource get _dataSource => getIt<FavoriteSource>();
  UserSource get _dataUserSource => getIt<UserSource>();


  Future<Either<Failure, String>> favoriteItem(FavoriteRequest request) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.favoriteItem(request);
    });
  }
  Future<Either<Failure, FavoriteDto>> favorites() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.favorites();
    });
  }
  Future<Either<Failure, String>> favoritesSeller(FavoriteSellerRequest request) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.favoritesSeller(request);
    });
  }
  Future<Either<Failure, FavoriteSellerDto>> getFavoritesSeller() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.getFavoritesSeller();
    });
  }
  Future<Either<Failure, bool>> deletedFavorites() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.deletedFavorites();
    });
  }
  Future<Either<Failure, FavoriteSearchDto>> favoriteSearch(String keySearch,String siteCode,String arrange) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.favoriteSearch(keySearch,siteCode,arrange);
    });
  }
  Future<Either<Failure, FavoriteSearchDto>> favoriteFilter(String siteCode) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.favoriteFilter(siteCode);
    });
  }
  Future<Either<Failure, AddressUserDto>> getAddressUser() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataUserSource.getAddressUser();
    });
  }
  Future<Either<Failure, bool>> editAddress(ItemsAddressUser item) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataUserSource.editAddress(item);
    });
  }

  Future<Either<Failure, ItemsAddressUser>> addAddress(ItemsAddressUser item) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataUserSource.addAddress(item);
    });
  }
  Future<Either<Failure, ServiceExtrasDto>> getServiceExtras() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataUserSource.getServiceExtras();
    });
  }
  Future<Either<Failure, ServiceExtrasDto>> confirmPaymentOder({required PaymentOderRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataUserSource.confirmPaymentOder(request: request);
    });
  }
  Future<Either<Failure, VoucherDto>> getCoupon({required ListRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataUserSource.getCoupon(request: request);
    });
  }

  Future<Either<Failure, ProvinceDto>> getProvince() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataUserSource.getProvince();
    });
  }
  Future<Either<Failure, DistrictDto>> getDistrict({required String provinceId}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataUserSource.getDistrict(provinceId);
    });
  }
  Future<Either<Failure, WardDto>> getWard({required String districtId}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataUserSource.getWard( districtId);
    });
  }
}