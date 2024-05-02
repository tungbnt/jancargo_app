part of 'cart_items_cubit.dart';

@immutable
abstract class CartItemsState {
  CartItemsState({required CartItemsState? state}) {
    groupCarts = state?.groupCarts;
    calculateCartDto = state?.calculateCartDto;
  }
  ValueNotifier<List<GroupCartsDto>>? groupCarts;
  CalculateCartDto? calculateCartDto;
  void copy(CartItemsState? state) {
    groupCarts = state?.groupCarts;
    calculateCartDto = state?.calculateCartDto;
  }
}
class CartItemsInitial extends CartItemsState {
   CartItemsInitial({required super.state});
}

class CartItemsLoading extends CartItemsState {
   CartItemsLoading({required super.state});
}

class CartItemsSuccess extends CartItemsState {
   CartItemsSuccess({

   required super.state});


}
class CartItemsEmpty extends CartItemsState {
   CartItemsEmpty({required super.state});


}
class RemoveLoadingCartItemsSuccess extends CartItemsSuccess {
   RemoveLoadingCartItemsSuccess({required super.state});
}
class RemoveCartItemsSuccess extends CartItemsSuccess {
   RemoveCartItemsSuccess({ required super.state});
}
class RemoveCartItemsFailed extends CartItemsSuccess {
  RemoveCartItemsFailed({ required super.state});
}
class UpdateCartItemsSuccess extends CartItemsSuccess {
  UpdateCartItemsSuccess({ required super.state});
}
class CalculateCartItemsLoading extends CartItemsSuccess {
  CalculateCartItemsLoading({ required super.state});
}
class GetCalculateCartItemsSuccess extends CartItemsSuccess {
  GetCalculateCartItemsSuccess({ required super.state});
}
class UpdateCartItemsFailed extends CartItemsSuccess {
  UpdateCartItemsFailed({ required super.state});
}