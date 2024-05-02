import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/data/object_request_api/auction/price_auction/price_auction_request.dart';
import 'package:jancargo_app/src/domain/dtos/cart/calculate_cart/calculate_cart_dto.dart';

import '../../../data/object_request_api/update_item_cart/update_item_cart_request.dart';
import '../../../domain/dtos/cart/item_cart/item_cart_dto.dart';
import '../../../domain/repositories/cart/cart_repo.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

part 'cart_items_state.dart';

class CartItemsCubit extends Cubit<CartItemsState> {
  CartItemsCubit() : super(CartItemsInitial(state: null));
  CartRepo get = getIt<CartRepo>();

  List<GroupCartsDto> groupCarts = [];
  ValueNotifier<int> total = ValueNotifier(0);
  ValueNotifier<int> selectedCount = ValueNotifier(0);

  //
  CalculateCartDto? calculateCartDto = CalculateCartDto();
  ValueNotifier<CalculateModel> calculateModel = ValueNotifier(CalculateModel(feeService: 0.0, feePayment: 0.0, serviceCurrent: 0.0, paymentCurrent: 0.0, discountService: 0.0, totalCurrent: 0.0, subCurrent: 0.0,));


  void toggleAllSelection(
      List<GroupCartsDto> dto,
      bool isSelected,
      ) {
    for (int i = 0; i < dto.length; i++) {
      dto[i].isSelected.value = isSelected;
      for (final e in dto[i].data!) {
        e.isSelected.value = isSelected;
      }
    }
    List<CalculateCartRequest> calculateCartList = [];

    dto.forEach((groupCartsDto) {
      groupCartsDto.data?.forEach((itemCartDto) {
        int exchangeRate = AppManager.appSession.exchange!;
        int price = itemCartDto.price!;
        int qty = itemCartDto.selectedAmount.value ?? 1;
        String routeCode = itemCartDto.shipMode!;
        int tax = 0;
        int originCountryShippingFee = 0;
        int mode = 1;


        CalculateCartRequest calculateCartRequest = CalculateCartRequest(
            exchangeRate: exchangeRate,
            price: price,
            mode: mode,
            originCountryShippingFee: originCountryShippingFee,
            qty: qty,
            routeCode: routeCode,
            tax: tax,
            weight: 0);
        calculateCartList.add(calculateCartRequest);
      });
    });
    updateTotal(PriceCalculateCartRequest(items: calculateCartList,routeCode: 'JP'));
  }

  void toggleStoreSelection(List<GroupCartsDto> listGroupCarts,
      GroupCartsDto dto, bool isSelected,) {
    dto.isSelected.value = isSelected;
    for (final e in dto.data!) {
      e.isSelected.value = isSelected;
    }
    List<CalculateCartRequest> calculateCartList = [];
    listGroupCarts.forEach((groupCartsDto) {
      groupCartsDto.data?.forEach((itemCartDto) {
        if (itemCartDto.isSelected.value) { // Kiểm tra isSelected
          int exchangeRate = AppManager.appSession.exchange!;
          int price = itemCartDto.price!;
          int qty = itemCartDto.selectedAmount.value ?? 1;
          String routeCode = itemCartDto.shipMode!;
          int tax = 0;
          int originCountryShippingFee = 0;
          int mode = 1;

          CalculateCartRequest calculateCartRequest = CalculateCartRequest(
            exchangeRate: exchangeRate,
            price: price,
            mode: mode,
            originCountryShippingFee: originCountryShippingFee,
            qty: qty,
            routeCode: routeCode,
            tax: tax,
            weight: 0,
          );
          calculateCartList.add(calculateCartRequest);
        }
      });
    });

    updateTotal(PriceCalculateCartRequest(items: calculateCartList,routeCode: 'JP'));
  }

  void toggleItemSelection(List<GroupCartsDto> listGroupCarts,
      GroupCartsDto dto, int index, bool isSelected,bool checkUp) {
    var itemCart = dto.data![index];
    itemCart.isSelected.value = isSelected;
    if (isSelected) {
      dto.isSelected.value = true;
    } else {
      dto.isSelected.value =
      !dto.data!.every((e) => e.isSelected.value == false);
    }
    List<CalculateCartRequest>? calculateCartList = [];
    listGroupCarts.forEach((groupCartsDto) {
      groupCartsDto.data?.forEach((itemCartDto) {
        if (itemCartDto.isSelected.value) { // Kiểm tra isSelected
          int exchangeRate = AppManager.appSession.exchange!;
          int price = itemCartDto.price!;
          int qty = itemCartDto.selectedAmount.value ?? 1;
          String routeCode = itemCartDto.shipMode!;
          int tax = 0;
          int originCountryShippingFee = 0;
          int mode = 1;

          CalculateCartRequest calculateCartRequest = CalculateCartRequest(
            exchangeRate: exchangeRate,
            price: price,
            mode: mode,
            originCountryShippingFee: originCountryShippingFee,
            qty: qty,
            routeCode: routeCode,
            tax: tax,
            weight: 0,
          );
          calculateCartList.add(calculateCartRequest);
        }
      });
    });
    updateTotal(PriceCalculateCartRequest(items: calculateCartList ?? [],routeCode: 'JP'));
  }

  void updateTotal(PriceCalculateCartRequest? request, ) {

    selectedCount.value =
        groupCarts.fold(0, (prev, e) => prev + e.selectedCount);
    var totalEmpty = groupCarts.fold(0, (prev, e) => prev + e.total.value);
    if(totalEmpty == 0)  {
      total.value = totalEmpty;
      return;
    }
    Future.delayed(Duration(milliseconds: 300), () {
      // calculate cart
      getCalculatePrice(request!);
    });


    print(selectedCount.value);
  }

  bool isLoading = false;

  void itemCart() async {
    emit(CartItemsLoading(state: null));

    isLoading == true;
    await Future.delayed(
      Duration(milliseconds: 2600),
    );

    final response = await get.itemCart();
    response.fold(
          (l) {
        // no action need analytics in future
      },
          (r) async {
        if (r.data!.isEmpty) {
          return emit(CartItemsEmpty(state: null));
        } else if (r.data!.isNotEmpty) {
          ///
          var group = await _cartGroup(r.data!);
          groupCarts = group;

          ///
          total.value = groupCarts.fold(0, (prev, e) => (prev + e.total.value));
          updateTotal(PriceCalculateCartRequest());
          if (group == []) {
            return emit(CartItemsEmpty(state: null));
          }
          // cal api lấy số tiền
          List<CalculateCartRequest> calculateCartList = [];

          groupCarts.forEach((groupCartsDto) {
            groupCartsDto.data?.forEach((itemCartDto) {
              if(itemCartDto.isSelected.value){
                int exchangeRate = AppManager.appSession.exchange!;
                int price = itemCartDto.price!;
                int qty = itemCartDto.selectedAmount.value ?? 1;
                String routeCode = itemCartDto.shipMode!;
                int tax = 0;
                int originCountryShippingFee = 0;
                int mode = 1;


                CalculateCartRequest calculateCartRequest = CalculateCartRequest(
                    exchangeRate: exchangeRate,
                    price: price,
                    mode: mode,
                    originCountryShippingFee: originCountryShippingFee,
                    qty: qty,
                    routeCode: routeCode,
                    tax: tax,
                    weight: 0);
                calculateCartList.add(calculateCartRequest);
              }

            });
          });
          updateTotal(PriceCalculateCartRequest(items: calculateCartList,routeCode: 'JP'));

          /// push data => success
          emit(CartItemsSuccess(
            state: state..groupCarts = ValueNotifier(group),
          ));

          //
          isLoading = false;
        }
      },
    );
  }

  void removeItemCart(
      List<String> idItemCart,
      ItemCartDto itemCart,
      final bool isRemoveAll,
      List<GroupCartsDto> newData,
      ) async {
    emit(
      RemoveLoadingCartItemsSuccess(
        state: state,
      ),
    );

    final response = await get.removeItemCart(idItemCart);

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if (r) {

        /// push data => success
        emit(
          RemoveCartItemsSuccess(
            state: state,
          )..groupCarts?.value = newData,
        );
        print('isRemoveAll status : $isRemoveAll');
        if (isRemoveAll) {
          total.value = 0;
          calculateCartDto = null;
          calculateModel.value = CalculateModel(feeService: 0.0, feePayment: 0.0, serviceCurrent: 0.0, paymentCurrent: 0.0, discountService: 0.0, totalCurrent: 0.0, subCurrent: 0.0,);

          emit(GetCalculateCartItemsSuccess(state: state));
          return;

        }
        ///
        updateTotal(
          PriceCalculateCartRequest(
            items: [
              CalculateCartRequest(
                  exchangeRate: AppManager.appSession.exchange!,
                  price: itemCart.price,
                  mode: 1,
                  originCountryShippingFee: 0,
                  qty: itemCart.qty,
                  routeCode: 'JP',
                  tax: 0,
                  weight: 0),
            ],
            routeCode: 'JP',
          ),
        );
      } else {
        emit(RemoveCartItemsFailed(state: state));

        ///
        updateTotal(
          PriceCalculateCartRequest(
            items: [
              CalculateCartRequest(
                  exchangeRate: AppManager.appSession.exchange!,
                  price: itemCart.price,
                  mode: 1,
                  originCountryShippingFee: 0,
                  qty: itemCart.qty,
                  routeCode: 'JP',
                  tax: 0,
                  weight: 0),
            ],
            routeCode: 'JP',
          ),
        );
      }
    });
  }

  void updateItemCart(
      {required ItemCartDto item}) async {
    final response =
    await get.updateItemCart(updateItemCartRequest: UpdateItemCartRequest(items: [
      ListUpdateItemCartRequest(
        id: item.id,
        qty: item.selectedAmount.value,
        selected: item.isSelected.value,
      )
    ]
    ));
    response.fold((l) {
      emit(UpdateCartItemsFailed(
        state: state,
      ));
    }, (r) async {

      if (r) {
        /// push data => success
        emit(UpdateCartItemsSuccess(
          state: state,
        ));
        ///
        // updateTotal(
        //   PriceCalculateCartRequest(
        //       items: [
        //         CalculateCartRequest(
        //             exchangeRate: AppManager.appSession.exchange!,
        //             price: item.price,
        //             mode: 1,
        //             originCountryShippingFee: 0,
        //             qty: item.qty ?? 1,
        //             routeCode: 'JP',
        //             tax: 0,
        //             weight: 0),
        //       ],
        //       routeCode: 'JP'
        //   ),
        // );
      } else {
        emit(UpdateCartItemsFailed(
          state: state,
        ));
      }
    });
  }


  void getCalculatePrice(PriceCalculateCartRequest request) async {
    emit(CalculateCartItemsLoading(state: state));
    final response = await get.getCalculatePrice(request: request);

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      //gán data
      calculateCartDto =  r;
      // lấy dữ liệu các số tiền
      calculate(r);
      // double totalJP = r.payment!.firstPayment!/AppManager.appSession.exchange!;
      // int newTotalVn = totalJP.round();
      // total.value = newTotalVn;
      emit(GetCalculateCartItemsSuccess(state: state)..calculateCartDto = r);
    });
  }
  void calculate(CalculateCartDto dto){
    if(selectedCount.value == 0){
       calculateCartDto = null;
      calculateModel = ValueNotifier(CalculateModel(feeService: 0.0, feePayment: 0.0, serviceCurrent: 0.0, paymentCurrent: 0.0, discountService: 0.0, totalCurrent: 0.0, subCurrent: 0.0,));
      return;
      }
    /// reset data calculateModel
    calculateCartDto = null;
    calculateModel = ValueNotifier(CalculateModel(feeService: 0.0, feePayment: 0.0, serviceCurrent: 0.0, paymentCurrent: 0.0, discountService: 0.0, totalCurrent: 0.0, subCurrent: 0.0,));

    calculateModel.value.totalCurrent = dto.payment!.totalFirst!.toDouble();
    calculateModel.value.subCurrent = dto.payment!.firstPayment!.toDouble();
    for (int i = 0; i < dto.data!.length; i++) {
      // Lấy ra danh sách các item trong mục hiện tại
      List<FeeDetailsDto>? items = dto.data![i].feeDetails;

      // tiền sản phẩm
      calculateModel.value.paymentCurrent += dto.data![i].taxVNCurrency!.toDouble();
      print('tiền hàng ${calculateModel.value.paymentCurrent}');

      // Kiểm tra xem danh sách items có tồn tại và không rỗng
      if (items != null && items.isNotEmpty) {
        // Duyệt qua từng item trong danh sách items
        for (int j = 0; j < items.length; j++) {

          // Kiểm tra xem item hiện tại có trường code và có giá trị là 'phi_thanh_toan' không
          if (items[j].code != null && items[j].code == 'phi-dich-vu') {
            calculateModel.value.feeService += items[j].vietnamCurrency!;
          }
          if (items[j].code != null && items[j].code == 'phi-thanh-toan') {
            calculateModel.value.feePayment += items[j].vietnamCurrency!;
          }
        }
      }
    }
  }

  Future<List<GroupCartsDto>> _cartGroup(List<ItemCartDto> dto) async {
    // Tạo một Map để nhóm các mặt hàng giỏ hàng theo mã
    Map<String, List<ItemCartDto>> groupedCart = {};
    for (ItemCartDto item in dto) {
      if (!groupedCart.containsKey(item.siteCode)) {
        groupedCart[item.siteCode!] = [];
      }
      groupedCart[item.siteCode]!.add(item);
    }

    // Chuyển đổi Map thành danh sách mới
    List<GroupCartsDto> cartGroups = groupedCart.entries.map((entry) {
      return GroupCartsDto(
        code: entry.key,
        data: entry.value,
      );
    }).toList();
    return cartGroups;
  }
}
