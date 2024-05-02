import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/data/object_request_api/auction/price_auction/price_auction_request.dart';
import 'package:jancargo_app/src/data/object_request_api/list_request/list_request.dart';
import 'package:jancargo_app/src/domain/dtos/cart/calculate_cart/calculate_cart_dto.dart';
import 'package:jancargo_app/src/domain/dtos/user/voucher/voucher_dto.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/modules/payment_oders/bloc/payment_order_item.dart';
import 'package:meta/meta.dart';

import '../../../data/object_request_api/payment_oder/payment_oder_request.dart';
import '../../../domain/dtos/cart/item_cart/item_cart_dto.dart';
import '../../../domain/dtos/user/address_user/address_user_dto.dart';
import '../../../domain/dtos/user/service_extras/service_extras_dto.dart';
import '../../../domain/dtos/user/tran_dto/tran_dto.dart';
import '../../../domain/dtos/user/warehouse/warehouse_dto.dart';
import '../../../domain/repositories/auction/auction_repo.dart';
import '../../../domain/repositories/cart/cart_repo.dart';
import '../../../domain/repositories/components/user/user_repo.dart';
import '../../../domain/repositories/detail_product/detail_product_repo.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

part 'payment_oders_state.dart';

class PaymentOdersCubit extends Cubit<PaymentOdersState> {
  PaymentOdersCubit() : super(PaymentOdersInitial(state: null));
  DetailProductRepo get = getIt<DetailProductRepo>();
  UserRepo getUser = getIt<UserRepo>();
  AuctionRepo getAuctionRepo = getIt<AuctionRepo>();
  CartRepo getCart = getIt<CartRepo>();
  final UserRepo _repo = getIt<UserRepo>();

  late ItemsAddressUser itemsAddressUser;
  late List<PaymentOrderItem>? paymentOrderItems;
   ValueNotifier<CalculateModel> calculateModel = ValueNotifier(CalculateModel(feeService: 0.0, feePayment: 0.0, serviceCurrent: 0.0, paymentCurrent: 0.0, discountService: 0.0, totalCurrent: 0.0, subCurrent: 0.0,));
  List<ShipModeDto>? shipModeDto = [];
  ServiceExtrasDto? serviceExtrasDto;

  ValueNotifier<bool> isActiveAgreeCondition = ValueNotifier(false);
  ValueNotifier<int> totalAmount = ValueNotifier(0);
  ValueNotifier<bool> isActivePayment = ValueNotifier(false);
  //số tiền hiện tại trong ví
  int currentAmount = 0;

  Future<void> getData({required CalculateCartDto dto}) async {
    try {
      List<PaymentOdersState?> statusListLoadDataSuccess = await Future.wait<PaymentOdersState?>(
          [_fetchAddress(), _getItemCart(), _fetchWareHouse(), _getWallet(), _getServiceExtras(),_fetchCoupon()]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is PaymentOdersDataSuccess &&
          statusListLoadDataSuccess[1] is PaymentOdersDataSuccess &&
          statusListLoadDataSuccess[2] is PaymentOdersDataSuccess &&
          statusListLoadDataSuccess[3] is PaymentOdersDataSuccess &&
          statusListLoadDataSuccess[4] is PaymentOdersDataSuccess &&
          statusListLoadDataSuccess[5] is PaymentOdersDataSuccess) {
        emit(
          statusListLoadDataSuccess[0]!
            ..copy(
              statusListLoadDataSuccess[1]
                ?..copy(
                  statusListLoadDataSuccess[2]
                    ?..copy(
                      statusListLoadDataSuccess[3]?..copy(statusListLoadDataSuccess[4]?..copy(statusListLoadDataSuccess[5]),),
                    ),
                ),
            ),
        );

        await Future.delayed(const Duration(seconds: 1));
      } else {
        // emit(DetailProductFailed(state: state));
      }
    } catch (e) {
      // emit(DetailProductFailed(state: state));
      print('${e} có lỗi xảy ra');
    }
  }

  Future<PaymentOdersState?> _fetchWareHouse() async {
    final response = await get.warehouse();
    PaymentOdersState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      // shipModeDto = [];
      for (int i = 0; i < r.results!.length; i++) {
        shipModeDto!.addAll(r.results![i].shipMode!.where((e) => e.active == true));
      }
      await Future.delayed(const Duration(seconds: 1));
      emit(WareHousePaymentOdersDataSuccess(state: state)
        ..wareHouseDataDto = (r.results)
        ..shipModeDto = shipModeDto);
      print('state là $state');

      state = PaymentOdersDataSuccess(state: state)
        ..wareHouseDataDto = r.results!
        ..shipModeDto = shipModeDto;
    });
    return state;
  }

  Future<PaymentOdersState?> _fetchAddress() async {
    final response = await getUser.getAddressUser();
    PaymentOdersState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AddressUserPaymentOdersDataSuccess(state: state)..addressUserDto = r);
      state = PaymentOdersDataSuccess(state: state)..addressUserDto = r;
    });
    return state;
  }

  Future<PaymentOdersState?> _getWallet() async {
    final response = await getAuctionRepo.getTran();
    PaymentOdersState? state;
    response.fold((l) {
      // no action need analytics in future
      print('lỗi ví');
    }, (r) async {
      // gán giá trị amount
      currentAmount = r.total!;

      emit(GetTranAuctionPaymentOdersDataSuccess(state: state)..tranDto = r);
      state = PaymentOdersDataSuccess(state: state)..tranDto = r;
    });
    return state;
  }

  Future<PaymentOdersState?> _getItemCart() async {
    final response = await getCart.itemCart();
    PaymentOdersState? state;
    response.fold((l) {
      // no action need analytics in future
      print('lỗi ví');
    }, (r) async {
      // lấy ra item có "selected" = true
      var carts = r.data?.where((e) => e.isSelected.value == true).toList();
      final paymentOrderItems = carts?.map(PaymentOrderItem.new).toList();

      state = GetItemCartPaymentOdersDataSuccess(state: state);
      state!.paymentOrderItems = paymentOrderItems;
      emit(state!);

      state = PaymentOdersDataSuccess(state: state);
      state!.paymentOrderItems = paymentOrderItems;
      emit(state!);
    });
    return state;
  }

  Future<PaymentOdersState?> _getServiceExtras() async {
    final response = await getUser.getServiceExtras();

    PaymentOdersState? state;

    response.fold((l) {
      // no action need analytics in future
      print('lỗi ví');
    }, (r) async {
      serviceExtrasDto = r;
      emit(GetServiceExtrasPaymentOdersDataSuccess(state: state)..serviceExtrasDto = r);
      state = PaymentOdersDataSuccess(state: state)..serviceExtrasDto = r;
    });

    return state;
  }

  Future<PaymentOdersState?> _fetchCoupon() async {
    PaymentOdersState? state;
    final response = await _repo.getCoupon(request: ListRequest(size: AppConstants.sizeApi,page: '0'));

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(CouponUserDataSuccess(state: state)..voucherDto = r);

    });
  return state;
  }

  void paymentOder() async {
    emit(ConfirmPaymentOdersLoading(state: state));
    List<QuotesPaymentOderRequest>? quotes;

    for (int i = 0; i < paymentOrderItems!.length; i++) {
      var item = paymentOrderItems![i];
      // index selected shipmode
      int indexSelectedShip = item.cartItem.selectedShip.value!;
      ShipModeDto itemShip = shipModeDto![indexSelectedShip];

      QuotesPaymentOderRequest requestItemQuote = QuotesPaymentOderRequest(
        id: item.cartItem.id,
        shipMode: itemShip.description,
      );
      // add item qoutes in list
      quotes!.add(requestItemQuote);
    }
    final response =
    await getUser.confirmPaymentOder(request: PaymentOderRequest(address: itemsAddressUser, quotes: quotes));
    response.fold((l) {
      // no action need analytics in future
      print('lỗi ví');
    }, (r) async {
      emit(ConfirmPaymentOdersDataSuccess(state: state)..serviceExtrasDto = r);
    });
  }

  void getCalculatePrice(PriceCalculateCartRequest request) async {
    emit(CalculatePaymentOdersLoading(state: state));
    final response = await getCart.getCalculatePrice(request: request);

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      //gán data
      emit(CalculatePaymentOdersDataSuccess(state: state)..calculateCartDto = r);
    });
  }

  void calculate(CalculateCartDto dto){
    calculateModel.value.totalCurrent = dto.payment!.totalFirst!.toDouble();
    calculateModel.value.subCurrent = dto.payment!.firstPayment!.toDouble();
    for (int i = 0; i < dto.data!.length; i++) {
      // Lấy ra danh sách các item trong mục hiện tại
      List<FeeDetailsDto>? items = dto.data![i].feeDetails;

      // tiền sản phẩm
      calculateModel.value.paymentCurrent += dto.data![i].taxVNCurrency!.toDouble();

      // Kiểm tra xem danh sách items có tồn tại và không rỗng
      if (items != null && items.isNotEmpty) {
        // Duyệt qua từng item trong danh sách items
        for (int j = 0; j < items.length; j++) {

          // Kiểm tra xem item hiện tại có trường code và có giá trị là 'phi_thanh_toan' không
          if (items[j].code != null && items[j].code == 'phi_dich_vu') {
              calculateModel.value.feeService += items[j].vietnamCurrency!;
          }
          if (items[j].code != null && items[j].code == 'phi-thanh-toan') {
            calculateModel.value.feePayment += items[j].vietnamCurrency!;
          }
        }
      }
    }
  }



  void isActivePay(int amountOfAllProduct) async {
    var hasAllShipMode = paymentOrderItems!.every((e) => e.selectedShipMethod.value != null);

    if(hasAllShipMode == false){
      return emit(IsActivePayPaymentOders(state: state)..isActivePay = false);

    }


    int serviceFee = 0;
    for (int i = 0; i < paymentOrderItems!.length; i++) {
      var item = paymentOrderItems![i];
      var amountServiceExtras = item.getTotalPriceForCodes(
        item.selectedServiceExtras.value,
      );
      amountOfAllProduct += amountServiceExtras;
    }

    //  tổng số tiền
    totalAmount.value = serviceFee + amountOfAllProduct;

    if (
        (currentAmount - (serviceFee + amountOfAllProduct) >= 0 ? true : false) &&
        isActiveAgreeCondition.value) {
      return emit(IsActivePayPaymentOders(state: state)..isActivePay = true);
    }
    //
    return emit(IsActivePayPaymentOders(state: state)..isActivePay = false);
  }

  void fetchAddress() async {
    emit(AddressUserLoading(state: state));
    final response = await getUser.getAddressUser();

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AddressUserDataSuccess(state: state)..addressUserDto = r);

    });

  }

}
