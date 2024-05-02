part of 'amazon_js_cubit.dart';

@immutable
abstract class AmazonJsState {
  AmazonJsState({required AmazonJsState? state}) {
    dto = state?.dto;
    sliderDto = state?.sliderDto;
  }

  AmazonJsDto? dto;
  BannerSliderDto? sliderDto;

  void copy(AmazonJsState? state) {
    dto = state?.dto;
    sliderDto = state?.sliderDto;
  }
}

class AmazonJsInitial extends AmazonJsState {
  AmazonJsInitial({required super.state});
}

class AmazonJsLoading extends AmazonJsState {
  AmazonJsLoading({required super.state});
}

class AmazonJsDataSuccess extends AmazonJsState {
  AmazonJsDataSuccess({required super.state});
}

class AmazonJsSliderDataSuccess extends AmazonJsDataSuccess {
  AmazonJsSliderDataSuccess({required super.state});
}

class AmazonJsItemsDataSuccess extends AmazonJsDataSuccess {
  AmazonJsItemsDataSuccess({required super.state});
}
