import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../data/object_request_api/add_cart/add_cart_request.dart';
import '../../../domain/dtos/cart/add_item_cart/add_item_cart_dto.dart';
import '../../../domain/dtos/cart/item_cart/item_cart_dto.dart';
import '../../../domain/repositories/cart/cart_repo.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial(state: null));
  CartRepo get = getIt<CartRepo>();

  List<GroupCartsDto> groupCarts = [];

  void addCart(AddCartRequest request) async {
    emit(CartLoading(state: state));
    Future.delayed(const Duration(milliseconds: 300), () {});
    final response = await get.addCart(request: request);
    response.fold((l) {
      emit(AddCartFailed(state: state));
    }, (r) async {
      emit(AddCartSuccess(state: state)..dto = r);
    });
  }

  void itemCart() async {
    emit(CartLoading(state: state));
    Future.delayed(const Duration(milliseconds: 300), () {});
    final response = await get.itemCart();
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      var group = await _cartGroup(r.data!);
      groupCarts = group;

      emit(ItemCartSuccess(state: state)..groupCarts = groupCarts);
    });
  }

  Future<List<GroupCartsDto>> _cartGroup(List<ItemCartDto> dto) async {
    // Tạo một Map để nhóm các mặt hàng giỏ hàng theo mã
    Map<String, List<ItemCartDto>> groupedCart = {};
    for (ItemCartDto item in dto) {
      if (!groupedCart.containsKey(item.code)) {
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
