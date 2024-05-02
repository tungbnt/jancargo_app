part of 'cart_cubit.dart';

@immutable
abstract class CartState {
  CartState({required CartState? state}) {
    dto = state?.dto;
    dtoCart = state?.dtoCart;
    groupCarts = state?.groupCarts;
  }

  AddItemCartDto? dto;
  CartDto? dtoCart;
  List<GroupCartsDto>? groupCarts;

  void copy(CartState? state) {
    dto = state?.dto;
    dtoCart = state?.dtoCart;
    groupCarts = state?.groupCarts;
  }
}

class CartInitial extends CartState {
  CartInitial({required super.state});
}

class CartLoading extends CartState {
  CartLoading({required super.state});
}

class AddCartSuccess extends CartState {
  AddCartSuccess({required super.state});
}

class AddCartFailed extends CartState {
  AddCartFailed({required super.state});
}

class ItemCartSuccess extends CartState {
  ItemCartSuccess({required super.state});
}

class ItemCartJanSuccess extends ItemCartSuccess {
  ItemCartJanSuccess({required super.state});
}
