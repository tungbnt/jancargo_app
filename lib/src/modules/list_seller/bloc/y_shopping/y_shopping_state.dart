part of 'y_shopping_cubit.dart';

@immutable
abstract class YShoppingState {
  YShoppingState({required YShoppingState? state}) {
    dto = state?.dto;
  }

  SearchShoppingDto? dto;

  void copy(YShoppingState? state) {
    dto = state?.dto;
  }
}

class YShoppingInitial extends YShoppingState {
  YShoppingInitial({required super.state});
}
class YShoppingLoading extends YShoppingState {
  YShoppingLoading({required super.state});
}

class YShoppingDataSuccess extends YShoppingState {
  YShoppingDataSuccess({required super.state});
}

class YShoppingFailed extends YShoppingState {
  YShoppingFailed({required super.state});
}
