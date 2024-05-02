part of 'coupon_cubit.dart';

@immutable
abstract class CouponState {
  CouponState({required CouponState? state}) {
    voucherDto = state?.voucherDto;
  }
  VoucherDto? voucherDto;

  void copy(CouponState? state) {
    voucherDto = state?.voucherDto;
  }
}

class CouponInitial extends CouponState {
  CouponInitial({required super.state});
}
class CouponLoading extends CouponState {
  CouponLoading({required super.state});
}
class CouponDataSuccess extends CouponState {
  CouponDataSuccess({required super.state});
}
class SearchCouponLoading extends CouponDataSuccess {
  SearchCouponLoading({required super.state});
}
class SearchCouponEmpty extends CouponDataSuccess {
  SearchCouponEmpty({required super.state});
}
class SearchCouponDataSuccess extends CouponDataSuccess {
  SearchCouponDataSuccess({required super.state});
}