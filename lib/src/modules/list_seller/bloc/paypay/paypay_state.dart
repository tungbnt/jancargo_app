part of 'paypay_cubit.dart';

@immutable
abstract class PaypayState {
  PaypayState({required PaypayState? state}) {
    dto = state?.dto;
    searchPopularDto = state?.searchPopularDto;
  }

  List<PaypaysDto>? dto;
  SearchPopularDto? searchPopularDto;

  void copy(PaypayState? state) {
    dto = state?.dto;
    searchPopularDto = state?.searchPopularDto;
  }
}

class PaypayInitial extends PaypayState {
  PaypayInitial({required super.state});
}

class PaypayLoading extends PaypayState {
  PaypayLoading({required super.state});
}

abstract class PaypayDataSuccess extends PaypayState {
  PaypayDataSuccess({required super.state});
}

class PaypayItemSuccess extends PaypayDataSuccess {
  PaypayItemSuccess({required super.state});
}

class PaypaySearchPopularDataSuccess extends PaypayDataSuccess {
  PaypaySearchPopularDataSuccess({required super.state});
}

class PaypayFailed extends PaypayState {
  PaypayFailed({required super.state});
}
