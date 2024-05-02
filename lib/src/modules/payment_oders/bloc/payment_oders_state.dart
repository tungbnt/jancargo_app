part of 'payment_oders_cubit.dart';

@immutable
abstract class PaymentOdersState {
  PaymentOdersState({required PaymentOdersState? state}) {
    wareHouseDataDto = state?.wareHouseDataDto;
    shipModeDto = state?.shipModeDto;
    addressUserDto = state?.addressUserDto;
    tranDto = state?.tranDto;
    cartDto = state?.cartDto;
    serviceExtrasDto = state?.serviceExtrasDto;
    voucherDto = state?.voucherDto;
    paymentOrderItems = state?.paymentOrderItems;
    calculateCartDto = state?.calculateCartDto;
    isActivePay = state?.isActivePay;
  }
  List<WareHouseDataDto>? wareHouseDataDto;
  List<ShipModeDto>? shipModeDto;
  AddressUserDto? addressUserDto;
  TranDto? tranDto;
  CartDto? cartDto;
  List<PaymentOrderItem>? paymentOrderItems;
  ServiceExtrasDto? serviceExtrasDto;
  VoucherDto? voucherDto;
  CalculateCartDto? calculateCartDto;
  bool? isActivePay;

  void copy(PaymentOdersState? state) {
    wareHouseDataDto = state?.wareHouseDataDto;
    shipModeDto = state?.shipModeDto;
    addressUserDto = state?.addressUserDto;
    tranDto = state?.tranDto;
    cartDto = state?.cartDto;
    serviceExtrasDto = state?.serviceExtrasDto;
    voucherDto = state?.voucherDto;
    paymentOrderItems = state?.paymentOrderItems;
    calculateCartDto = state?.calculateCartDto;
    isActivePay = state?.isActivePay;
  }
}

class PaymentOdersInitial extends PaymentOdersState {
  PaymentOdersInitial({required super.state});
}
class PaymentOdersDataSuccess extends PaymentOdersState {
  PaymentOdersDataSuccess({required super.state});
}
class AddressUserLoading extends PaymentOdersState {
  AddressUserLoading({required super.state});
}
class AddressUserDataSuccess extends PaymentOdersState {
  AddressUserDataSuccess({required super.state});
}
class CouponUserDataSuccess extends PaymentOdersState {
  CouponUserDataSuccess({required super.state});
}
class WareHousePaymentOdersDataSuccess extends PaymentOdersDataSuccess {
  WareHousePaymentOdersDataSuccess({required super.state});
}

class AddressUserPaymentOdersDataSuccess extends PaymentOdersDataSuccess {
  AddressUserPaymentOdersDataSuccess({required super.state});
}
class GetTranAuctionPaymentOdersDataSuccess extends PaymentOdersDataSuccess {
  GetTranAuctionPaymentOdersDataSuccess({required super.state});
}
class GetItemCartPaymentOdersDataSuccess extends PaymentOdersDataSuccess {
  GetItemCartPaymentOdersDataSuccess({required super.state});
}
class GetServiceExtrasPaymentOdersDataSuccess extends PaymentOdersDataSuccess {
  GetServiceExtrasPaymentOdersDataSuccess({required super.state});
}
class ConfirmPaymentOdersLoading extends PaymentOdersDataSuccess {
  ConfirmPaymentOdersLoading({required super.state});
}
class ConfirmPaymentOdersDataSuccess extends PaymentOdersDataSuccess {
  ConfirmPaymentOdersDataSuccess({required super.state});
}
class CalculatePaymentOdersLoading extends PaymentOdersDataSuccess {
  CalculatePaymentOdersLoading({required super.state});
}
class CalculatePaymentOdersDataSuccess extends PaymentOdersDataSuccess {
  CalculatePaymentOdersDataSuccess({required super.state});
}

class IsActivePayPaymentOders extends PaymentOdersDataSuccess {
  IsActivePayPaymentOders({required super.state});
}
