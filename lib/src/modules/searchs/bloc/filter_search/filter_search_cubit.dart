import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/modules/searchs/widget/filter_default_radio.dart';

import '../../../../components/resource/molecules/radio_button.dart';

part 'filter_search_state.dart';

class FilterSearchCubit extends Cubit<FilterSearchState> {
  FilterSearchCubit() : super(FilterSearchInitial());

  ValueNotifier<int> currentIndexStack = ValueNotifier((0));
  // for filter_ price
  final ValueNotifier<bool> showPriceFilter = ValueNotifier(true);
  final ValueNotifier<bool> showDelete = ValueNotifier(false);
  final ValueNotifier<bool> showDeleteOnResult = ValueNotifier(false);
  TextEditingController priceFromCtrl = TextEditingController();
  TextEditingController priceToCtrl = TextEditingController();
  TextEditingController priceFromCtrlOnResult = TextEditingController();
  TextEditingController priceToCtrlOnResult = TextEditingController();

  // for filter_size
  final ValueNotifier<bool> hasFilter = ValueNotifier(false);
  final ValueNotifier<bool> showSizeFilter = ValueNotifier(false);
  final ValueNotifier<bool> titleFilterSize = ValueNotifier(false);
  final ValueNotifier<String> titleFilterSizeOnResult = ValueNotifier("");

  List<RadioBoxModel> sizes = [];
  List<RadioBoxModel> sizesOnResult = [];

  // for filter_ color
  final ValueNotifier<bool> showColor = ValueNotifier(false);
  final ValueNotifier<String> titleFilterColors = ValueNotifier("");
  final ValueNotifier<String> titleFilterColorsOnResult = ValueNotifier("");

  final List<RadioBoxModel> colors = [];
  final List<RadioBoxModel> colorsOnResult = [];

  /// another type of filter is converted to use in view
  final List<FilterDefaultRadioController> listFilterModel = [];
  final List<FilterDefaultRadioController> listFilterModelOnResult = [];

  void clearPrice() {
    if (currentIndexStack.value == 0) {
      priceFromCtrl.clear();
      priceToCtrl.clear();
      showDelete.value = false;
    } else {
      priceFromCtrlOnResult.clear();
      priceToCtrlOnResult.clear();
      showDeleteOnResult.value = false;
    }
    // onChangeFilter();
  }

  void onChangeFilter() {
    if (currentIndexStack.value == 0) {
      if (priceFromCtrl.text.isNotEmpty || priceToCtrl.text.isNotEmpty) {
        showDelete.value = true;
      } else {
        showDelete.value = false;
      }
    } else {
      if (priceFromCtrlOnResult.text.isNotEmpty || priceToCtrlOnResult.text.isNotEmpty) {
        showDeleteOnResult.value = true;
      } else {
        showDeleteOnResult.value = false;
      }
    }
  }

  //
  void clearParamsFilter({
    required List<RadioBoxModel> sizes,
    required List<RadioBoxModel> colors,
    // required List<CheckBoxModel<Map<String, dynamic>>> galleries,
    // required List<CheckBoxModel<Map<String, dynamic>>> categories,
    required List<FilterDefaultRadioController> listFilterModel,
  }) {
    // for (var element in sizes) {
    // }

    // for (var element in colors) {
    // }

    // for (var element in categories) {
    // }

    // for (var element in galleries) {
    // }

    /// clear filter for another type of filter
    for (var element in listFilterModel) {
      element.clearFilter();
    }
    clearPrice();
  }

  void clearAllFilter({
    // Function(ProductListRequest productListRequest)? onSubmitFilter,
    required bool fromListProduct,
    FilterSearchCubit? tempCubit,
  }) async {
    if (fromListProduct) {
      if (currentIndexStack.value == 0) {
        // hasFilter.value = false;
        clearParamsFilter(
          sizes: sizes,
          colors: colors,
          listFilterModel: listFilterModel,
        );
      } else {
        clearParamsFilter(
          sizes: sizesOnResult,
          colors: colorsOnResult,
          listFilterModel: listFilterModelOnResult,
        );
      }
    } else {
      tempCubit?.clearParamsFilter(
        sizes: tempCubit.sizes,
        colors: tempCubit.colors,
        listFilterModel: tempCubit.listFilterModel,
      );
    }
  }
}
